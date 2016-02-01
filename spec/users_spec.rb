require File.expand_path '../spec_helper.rb', __FILE__

describe 'Creating a new user' do
  let(:current_time) { Time.now.to_s }
  it 'creates a new user' do
    Oxidized::Web::Models::Users.new do |u|
      u.first_name = 'Oxidized'
      u.last_name = 'Web'
      u.client_id = 'random'
      u.client_secret = 'number'
      u.privilege_level = 15
      u.created_at = current_time
      u.save
    end
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
    expect {
      Oxidized::Web::Models::Users.new do |u|
        u.first_name = 'Hodor'
        u.last_name = 'the Great'
        u.client_id = 'random'
        u.client_secret = 'supersecret'
        u.privilege_level = 7
        u.created_at = current_time
        u.save
      end
    }.to raise_exception(Sequel::UniqueConstraintViolation)
  end

  it 'can create multiple client ids for the same person' do
    Oxidized::Web::Models::Users.new do |u|
      u.first_name = 'Oxidized'
      u.last_name = 'Web'
      u.client_id = 'hodor'
      u.client_secret = 'number'
      u.privilege_level = 15
      u.created_at = current_time
      u.save
    end
  end

  after :all do
    Oxidized::Web::Models::Users.filter(client_id: 'random').delete
    Oxidized::Web::Models::Users.filter(client_id: 'hodor').delete
  end
end

describe 'Deleting a new user' do
  let(:current_time) { Time.now.to_s }
  before do
    Oxidized::Web::Models::Users.new do |u|
      u.first_name = 'Oxidized'
      u.last_name = 'Web'
      u.client_id = 'random'
      u.client_secret = 'number'
      u.privilege_level = 15
      u.created_at = current_time
      u.save
    end
  end

  it 'deletes a user' do
    Oxidized::Web::Models::Users.filter(client_id: 'random').delete
    expect(Oxidized::Web::Models::Users.filter(client_id: 'random')).to be_empty
  end
end
