class FeedsController < ApplicationController
  def index
    @feeds = TwitterClient.new(keyword: feed_params).search
  end

  def feed_params
    params.require(:keyword)
  end
end
