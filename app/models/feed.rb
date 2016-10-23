require 'rss'

class Feed < ActiveRecord::Base
  paginates_per 20

  def self.fetch_feeds(url)
    RSS::Parser.parse(url).items
  end

  def self.save_feeds(feeds)
    feeds.each do |feed|
      if !Feed.find_by(url: feed.link)
        feed = Feed.new(
          title: feed.title,
          url: feed.link,
          entry_created: feed.pubDate
        )
        feed.save
      end
    end
  end

  def self.update_feeds(url)
    feeds = fetch_feeds(url)
    save_feeds(feeds)
  end
end
