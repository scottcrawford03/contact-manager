require 'rails_helper'

describe 'the company view', type: :feature do

  let(:company) { Company.create(name: 'Target') }

  describe 'phone numbers' do


    before(:each) do
      company.phone_numbers.create(number: '1112223333')
      company.phone_numbers.create(number: '2223334444')
      visit company_path(company)
    end

    it 'shows the phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has link to add new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: company.id,
                                                                                contact_type: 'Company'))
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-8888')
    end

    it 'has link to edit phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it ' has link to delete phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'deletes a phone number' do
      phone = company.phone_numbers.first

      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(phone.number)
    end
  end

  describe 'email addresses' do
    before(:each) do
      company.email_addresses.create(address: 'hello@example.com')
      company.email_addresses.create(address: 'goodbye@example.com')
      visit company_path(company)
    end

    it 'has LIs for each address' do
      expect(page).to have_selector('li', text: 'hello@example.com')
      expect(page).to have_selector('li', text: 'goodbye@example.com')
    end

    it 'has an add email address link' do
      expect(page).to have_link('new email address', href: new_email_address_path(contact_id: company.id, contact_type: 'Company' ))
    end

    it 'sends a user to add a new email' do
      first(:link, 'new email address').click
      expect(current_path).to eq(new_email_address_path)
    end

    it 'adds a new email address' do
      first(:link, 'new email address').click
      page.fill_in('Address', with: 'goodbye@example.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('goodbye@example.com')
    end

    it 'has a delete email link' do
      company.email_addresses.each do |email|
        expect(page).to have_link('delete', href: email_address_path(email))
      end
    end

    it 'deletes an email address' do
      email = company.email_addresses.first

      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(email)
    end

    it 'has an edit email link' do
      company.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end

    it 'edits an email' do
      email = company.email_addresses.first
      old_email = email.address

      first(:link, 'edit').click
      page.fill_in('Address', with: 'yolo@example.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('yolo@example.com')
      expect(page).to_not have_content(old_email)
    end
  end
end
