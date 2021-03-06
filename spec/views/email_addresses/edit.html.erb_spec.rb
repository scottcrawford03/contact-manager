require 'rails_helper'

RSpec.describe "email_addresses/edit", :type => :view do
  before(:each) do
    @email_address = assign(:email_address, EmailAddress.create!(
      :address => "MyString",
      :contact_id => 1,
      :contact_type => 'Person'
    ))
  end

  it "renders the edit email_address form" do
    render

    assert_select "form[action=?][method=?]", email_address_path(@email_address), "post" do

      assert_select "input#email_address_address[name=?]", "email_address[address]"

      assert_select "input#email_address_contact_id[name=?]", "email_address[contact_id]"
    end
  end

  it 'shows the contact name in the title' do
    render
    assert_select('h1', text: "Editing Email Address")
  end
end
