class UrlsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]
  before_action :find_url, only: [:show, :destroy]

  def index
    @urls = current_user.urls
  end
  
  def new
    @url = Url.new
  end

  def create
    if user_signed_in?
      url = current_user.urls.build(url_params)
    else
      url = Url.new(url_params)
    end
    if url.valid?
      url.save
      flash[:notice] = "Url shortened successfully."
      redirect_to url
    else
      flash[:alert] = url.errors.full_messages[0]
      redirect_back(fallback_location: root_url)
    end
  end

  def show
    redirect_to root_url unless @url
  end

  def destroy
    @url.destroy
    flash[:notice] = 'Link deleted successfully.'
    redirect_to root_url
  end

  def shortened_link
    url = Url.find_by(url_digest: params[:url_digest])
    redirect_to root_url unless url
    if Tracker::PLATFORMS === browser.platform.to_s
      url.trackers.create(platform: browser.platform.to_s)
    else
      url.trackers.create(platform: 'other')
    end
    redirect_to url.full_url
  end

  private
  
  def url_params
    params.require(:url).permit(:full_url)
  end

  def find_url
    if user_signed_in?
      @url = current_user.urls.find(params[:id])
    else
      @url = Url.find(params[:id])
      unless @url.user.nil?
        flash[:alert] = "You're not authorized to access this link!"
        redirect_to root_url
        return
      end
    end
  end
end
