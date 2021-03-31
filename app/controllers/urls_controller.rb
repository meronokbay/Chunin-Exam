class UrlsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]

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
      flash[:notice] = "Url was shortened successfully"
      redirect_to shortened_link_url(url.url_digest)
    else
      flash[:alert] = url.errors.full_messages
      redirect_to root_url
    end
  end

  def show
    @url = Url.find_by(url_digest: params[:url_digest])
    redirect_to root_url unless @url
    if Tracker::PLATFORMS === browser.platform.to_s
      @url.trackers.create(platform: browser.platform.to_s)
    else
      @url.trackers.create(platform: 'other')
    end
  end

  private
  
  def url_params
    params.require(:url).permit(:full_url)
  end
end
