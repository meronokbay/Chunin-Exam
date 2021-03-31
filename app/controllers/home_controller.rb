class HomeController < ApplicationController
  def index
    unless user_signed_in?
      @url = Url.new
    else
      redirect_to urls_url
    end
  end
end
