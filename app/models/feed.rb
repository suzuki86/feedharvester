require 'rss'

class Feed < ActiveRecord::Base
  belongs_to :endpoint

  paginates_per 20

  def self.fetch_feeds(url)
    RSS::Parser.parse(url)
  end

  def self.save_feeds(endpoint_id, feeds)
    if feeds.class == RSS::RDF
      entry_created_method_name = "dc_date"
    elsif feeds.class == RSS::Rss
      entry_created_method_name = "pubDate"
    end

    feeds.items.each do |feed|
      if !Feed.find_by(url: feed.link)
        feed = Feed.new(
          endpoint_id: endpoint_id,
          title: feed.title,
          url: feed.link,
          entry_created: feed.send(entry_created_method_name)
        )
        feed.save
      end
    end
  end

  def self.save_rdf(endpoint_id, feeds)
    feeds.items.each do |feed|
      if !Feed.find_by(url: feed.link)
        feed = Feed.new(
          endpoint_id: endpoint_id,
          title: feed.title,
          url: feed.link,
          entry_created: feed.dc_date
        )
        feed.save
      end
    end
  end

  def self.save_rss(endpoint_id, feeds)
    feeds.items.each do |feed|
      if !Feed.find_by(url: feed.link)
        feed = Feed.new(
          endpoint_id: endpoint_id,
          title: feed.title,
          url: feed.link,
          entry_created: feed.pubDate
        )
        feed.save
      end
    end
  end

  def self.update_feeds(endpoint_id)
    ep = Endpoint.find_by(endpoint_id)
    feeds = fetch_feeds(ep.endpoint)
    save_feeds(endpoint_id, feeds)
  end
end
