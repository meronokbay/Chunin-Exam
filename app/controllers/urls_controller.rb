class UrlsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new]
  before_action :find_url, only: %i[show destroy]

  def index
    @urls = current_user.urls
  end

  def new
    @url = Url.new
  end

  def create
    url = if user_signed_in?
            current_user.urls.build(url_params)
          else
            Url.new(url_params)
          end
    if url.valid?
      url.save
      flash[:notice] = 'Url shortened successfully.'
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
    if Tracker::PLATFORMS.include? browser.platform.to_s
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
      @url = current_user.urls.find_by(id: params[:id])
      redirect_if_falsy !@url.nil?
    else
      @url = Url.find_by(id: params[:id])
      redirect_if_falsy @url.user.nil?
    end
  end

  def redirect_if_falsy(value)
    return if value

    flash[:alert] = "Link doesn't exist!"
    redirect_to root_url
  end
end
