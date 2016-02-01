require File.expand_path '../spec_helper.rb', __FILE__

describe 'Creating a new user' do
  let(:current_time) { Time.now.to_s }
  it 'creates a new user' do
    create_user 'random', 'number'
  end

  let(:user) { Oxidized::Web::Models::Users.first(client_id: 'random') }

  it 'has the correct attributes' do
    expect(user[:first_name]).to eq('Oxidized')
    expect(user[:last_name]).to eq('Web')
    expect(user[:client_id]).to eq('random')
    expect(user[:client_secret]).to eq('number')
    expect(user[:privilege_level]).to eq(15)
    expect(user[:created_at].to_s).to eq(current_time)
  end

  it 'cannot create the same client id' do
    expect do
      create_user 'random', 'supersecret'
    end.to raise_exception(Sequel::UniqueConstraintViolation)
  end

  it 'can create multiple client ids for the same person' do
    create_user 'hodor', 'number'
  end

  after :all do
    Oxidized::Web::Models::Users.filter(client_id: 'random').delete
    Oxidized::Web::Models::Users.filter(client_id: 'hodor').delete
  end
end

describe 'Deleting a new user' do
  let(:current_time) { Time.now.to_s }
  before do
    create_user 'random', 'number'
  end

  it 'deletes a user' do
    Oxidized::Web::Models::Users.filter(client_id: 'random').delete
    expect(Oxidized::Web::Models::Users.filter(client_id: 'random')).to be_empty
  end
end
