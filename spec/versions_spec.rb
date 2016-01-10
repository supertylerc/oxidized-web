require File.expand_path '../spec_helper.rb', __FILE__

describe 'Getting a version for a single node' do
  let(:expected) do
    [{
      commit: {
        hash: '9e890265f00a7369e25e7ef2de92e5f94a65a0ab',
        date: '2016-01-02T20:06:13Z',
        author: {
          email: 'oxidized@tylerc.me',
          name: 'oxidized',
          date: '2016-01-02T20:06:13Z'
        },
        message: 'update rtr1.example.com'
      }
    }]
  end
  before do
    get '/versions/default/rtr1.example.com'
  end
  let(:response) { JSON.parse(last_response.body, symbolize_names: true) }
  it 'should return a version for a node' do
    expect(response).to eq(expected)
  end
  it 'should be successful' do
    expect(last_response).to be_ok
  end
end

describe 'Getting the latest version for a node' do
  let(:expected) do
    {
      commit: {
        hash: '9e890265f00a7369e25e7ef2de92e5f94a65a0ab',
        date: '2016-01-02T20:06:13Z',
        author: {
          email: 'oxidized@tylerc.me',
          name: 'oxidized',
          date: '2016-01-02T20:06:13Z'
        },
        message: 'update rtr1.example.com'
      }
    }
  end

  before do
    get '/versions/default/rtr1.example.com/latest'
  end

  let(:response) { JSON.parse(last_response.body, symbolize_names: true) }
  it 'should return the latest version for a node' do
    expect(response).to eq(expected)
  end

  it 'should be successful' do
    expect(last_response).to be_ok
  end
end

describe 'Getting a list of versions for all nodes' do
  let(:expected) do
    {
      default: {
        :'rtr1.example.com' => [{
          commit: {
            hash: '9e890265f00a7369e25e7ef2de92e5f94a65a0ab',
            date: '2016-01-02T20:06:13Z',
            author: {
              email: 'oxidized@tylerc.me',
              name: 'oxidized',
              date: '2016-01-02T20:06:13Z'
            },
            message: 'update rtr1.example.com'
          }
        }]
      }
    }
  end

  before do
    get '/versions'
  end

  let(:response) { JSON.parse(last_response.body, symbolize_names: true) }
  it 'should return a list of versions for all nodes' do
    expect(response).to eq(expected)
  end

  it 'should be successful' do
    expect(last_response).to be_ok
  end
end
