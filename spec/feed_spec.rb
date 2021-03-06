require 'spec_helper'
require 'rails_helper'

describe Feed do
  before do
    FactoryGirl.create(:dummy_endpoints)
  end

  let(:dummy_rdf) do
    RSS::Parser.parse(File.read("spec/dummy_rdf.rdf"))
  end

  let(:dummy_rss) do
    RSS::Parser.parse(File.read("spec/dummy_rss.xml"))
  end

  it "saves rdf feeds correctly" do
    allow(Feed).to receive(:fetch_feeds).and_return(dummy_rdf)
    feeds = Feed.fetch_feeds("http://example.com/rdf")
    Feed.save_rdf(1, feeds)
    expect(Feed.first.title).to eq "記事タイトル1"
  end

  it "saves rss feeds correctly" do
    allow(Feed).to receive(:fetch_feeds).and_return(dummy_rss)
    feeds = Feed.fetch_feeds("http://example.com/rss")
    Feed.save_rss(1, feeds)
    expect(Feed.first.title).to eq "Entry Title 1"
  end

  it "save rss feeds correctly" do
    allow(Feed).to receive(:fetch_feeds).and_return(dummy_rss)
    feeds = Feed.fetch_feeds("http://example.com/rss")
    Feed.save_feeds(1, feeds)
    expect(Feed.first.title).to eq "Entry Title 1"
  end

  it "save rdf feeds correctly" do
    allow(Feed).to receive(:fetch_feeds).and_return(dummy_rdf)
    feeds = Feed.fetch_feeds("http://example.com/rdf")
    Feed.save_feeds(1, feeds)
    expect(Feed.first.title).to eq "記事タイトル1"
  end
end
