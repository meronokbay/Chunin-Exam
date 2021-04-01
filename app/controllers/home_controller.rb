class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to urls_url
    else
      @url = Url.new
    end
  end
end
