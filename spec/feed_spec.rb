require 'spec_helper'
require 'rails_helper'

describe Feed do
  before do
    FactoryGirl.create(:dummy_endpoints)
  end

  let(:dummy_rdf) do
    RSS::Parser.parse(File.read("spec/dummy_rdf.rdf"))
  end

  it "saves rdf feeds correctly" do
    allow(Feed).to receive(:fetch_feeds).and_return(dummy_rdf)
    feeds = Feed.fetch_feeds("http://example.com/rdf")
    Feed.save_rdf(1, feeds)
    expect(Feed.first.title).to eq "記事タイトル1"
  end
end
