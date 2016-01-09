require File.expand_path '../spec_helper.rb', __FILE__

describe 'Getting an invalid URI' do
  let(:expected) do
    {
      error: "Not Found Exception",
      message: "The requested resource was not found",
      code: {
        subcode: 1,
        code: 404
      }
    }
  end
  before do
    get '/hodor'
  end
  let(:response) { JSON.parse(last_response.body, symbolize_names: true) }
  it 'should return a custom 404 error' do
    expect(response).to eq(expected)
  end
  it 'should fail' do
    expect(last_response).to_not be_ok
  end
end
