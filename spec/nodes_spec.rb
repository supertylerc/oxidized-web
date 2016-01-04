require File.expand_path '../spec_helper.rb', __FILE__

describe "Getting a list of nodes" do
  let(:expected) {
    [{
      name: "rtr1.example.com",
      last: {
        start: "2016-01-03T03:22:27Z",
        end: "2016-01-03T03:22:29Z",
        status: "success",
        time: 1.516074609
      },
      group: "default",
      full_name: "default/rtr1.example.com",
      vars: {}
    }]
  }
  before do
    get '/nodes'
  end
  let(:response) { JSON.parse(last_response.body, symbolize_names: true) }
  it "should return a list of nodes" do
    expect(response).to eq(expected)
  end
  it "should be successful" do
    expect(last_response).to be_ok
  end
end

describe "Getting a single node" do
  let(:expected) {
    {
      name: "rtr1.example.com",
      last: {
        start: "2016-01-03T03:22:27Z",
        end: "2016-01-03T03:22:29Z",
        status: "success",
        time: 1.516074609
      },
      group: "default",
      full_name: "default/rtr1.example.com",
      vars: {}
    }
  }
  before do
    get '/nodes/rtr1.example.com'
  end
  let(:response) { JSON.parse(last_response.body, symbolize_names: true) }
  it "should return a list of nodes" do
    expect(response).to eq(expected)
  end
  it "should be successful" do
    expect(last_response).to be_ok
  end
end
