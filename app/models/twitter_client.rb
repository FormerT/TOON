class TwitterClient
  TAKE_COUNT = 10
  include ActiveModel::Model

  attr_accessor :client, :keyword

  validates :keyword, presence: true

  def initialize(attributes={})
    super
    if enable?
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TW_CONSUMER_KEY']
        config.consumer_secret = ENV['TW_CONSUMER_SECRET']
        config.access_token = ENV['TW_ACCESS_TOKEN']
        config.access_token_secret = ENV['TW_ACCESS_SECRET']
      end
    end
  end

  def search
    return tweet unless enable?
    client.search("#{@keyword} -rt", lang: 'ja').take(TAKE_COUNT).collect do |tweet_content|
      tweet(tweet_content)
    end
  end

  private

  def enable?
    ENV['ENABLE_TW'].present?
  end

  def tweet(content=nil)
    struct = Struct.new(:username, :screenname, :text, :profile_image_url)
    return [
      struct.new(
        'dummy name1',
        'dummy screen name1',
        'dummy text1',
        nil,
      ),
      struct.new(
        'dummy name2',
        'dummy screen name2',
        'dummy text2',
        nil,
      )
    ] unless enable?
    struct.new(
      content.user.name,
      content.user.screen_name,
      content.text,
      content.user.profile_image_url
    )
  end
end
