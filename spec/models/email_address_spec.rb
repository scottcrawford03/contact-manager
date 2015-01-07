require 'rails_helper'

RSpec.describe EmailAddress, :type => :model do
  let(:email_address) do
     EmailAddress.new(address: 'hello@example.com')
  end

  it 'is valid' do
    expect(email_address).to be_valid
  end

  it 'is invalid without an email' do
    email_address.address = nil
    expect(email_address).to_not be_valid
  end
end
