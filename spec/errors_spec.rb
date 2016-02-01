require File.expand_path '../spec_helper.rb', __FILE__

describe 'Getting an invalid URI' do
  let(:expected) do
    {
      error: 'Not Found Exception',
      message: 'The requested resource was not found',
      code: {
        subcode: 1,
        code: 404
      }
    }
  end
  before do
    route = '/hodor'
    header 'AUTHORIZATION', "#{$CLIENT_ID}:#{sign($CLIENT_SECRET, route)}"
    get route
  end
  let(:response) { JSON.parse(last_response.body, symbolize_names: true) }
  it 'should return a custom 404 error' do
    expect(response).to eq(expected)
  end

  it 'should fail' do
    expect(last_response).to_not be_ok
  end

  it 'should return an HTTP 404 code' do
    expect(last_response.status).to eq(404)
  end
end

describe 'Sending an invalid HMAC' do
  before do
    route = '/nodes'
    header 'AUTHORIZATION', "#{$CLIENT_ID}:#{sign('hodor', route)}"
    get route
  end

  it 'should fail' do
    expect(last_response).to_not be_ok
  end

  it 'should return an HTTP 401 code' do
    expect(last_response.status).to eq(401)
  end
end

describe 'Omitting the AUTHORIZATION header' do
  before do
    route = '/nodes'
    get route
  end

  it 'should fail' do
    expect(last_response).to_not be_ok
  end

  it 'should return an HTTP 403 code' do
    expect(last_response.status).to eq(403)
  end
end
