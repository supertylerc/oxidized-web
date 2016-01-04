require File.expand_path '../spec_helper.rb', __FILE__

describe "Getting a version for a single node" do
  let(:expected) {
    {
      commit: {
        hash: "9e890265f00a7369e25e7ef2de92e5f94a65a0ab",
        date: "2016-01-02T20:06:13Z",
        author: {
          email: "oxidized@tylerc.me",
          name: "oxidized",
          date: "2016-01-02T20:06:13Z"
        },
        message: "update 192.168.33.2"
      }
    }
  }
  before do
    get '/versions/rtr1.example.com'
  end
  let(:response) { JSON.parse(last_response.body, symbolize_names: true) }
  it "should return a version for a node" do
    expect(response).to eq(expected)
  end
  it "should be successful" do
    expect(last_response).to be_ok
  end
end
