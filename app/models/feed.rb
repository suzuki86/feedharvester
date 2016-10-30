require 'rss'

class Feed < ActiveRecord::Base
  belongs_to :entrypoint

  paginates_per 20

  def self.fetch_feeds(url)
    RSS::Parser.parse(url).items
  end

  def self.save_feeds(entrypoint_id, feeds)
    feeds.each do |feed|
      if !Feed.find_by(url: feed.link)
        feed = Feed.new(
          entrypoint_id: entrypoint_id,
          title: feed.title,
          url: feed.link,
          entry_created: feed.pubDate
        )
        feed.save
      end
    end
  end

  def self.update_feeds(entrypoint_id)
    ep = Entrypoint.find_by(entrypoint_id)
    feeds = fetch_feeds(ep.entrypoint)
    save_feeds(entrypoint_id, feeds)
  end
end
