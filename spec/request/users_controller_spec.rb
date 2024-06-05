# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  before do
    @user1 = FactoryBot.create(:user, name: 'John Doe')
    @user2 = FactoryBot.create(:user, name: 'Jane Doe')
    @user3 = FactoryBot.create(:user, name: 'Alice Smith')
  end
  # rubocop:disable Metrics/BlockLength

  describe 'GET /users' do
    it 'returns a success response' do
      visit users_path
      expect(page).to have_http_status(:success)
    end

    it 'displays all users' do
      visit users_path
      expect(page).to have_content('John Doe')
      expect(page).to have_content('Jane Doe')
      expect(page).to have_content('Alice Smith')
    end

    it 'returns users matching the search query' do
      visit users_path
      fill_in 'search', with: 'Doe'
      click_button 'Search'
      expect(page).to have_content('John Doe')
      expect(page).to have_content('Jane Doe')
      expect(page).not_to have_content('Alice Smith')
    end

    context 'It paginate the user records' do
      let!(:users) { create_list(:user, 15) }
      it 'paginates users' do
        visit users_path
        expect(page).to have_selector('.pagination')
        click_link '2'
        expect(page).to have_selector('span.page.current', text: '2')
        expect(page).to have_selector('td', text: users.last.name)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'deletes the user' do
      visit users_path
      expect do
        within('tr', text: @user.name) do
          click_button 'Delete'
        end
        expect(page.body).not_to have_content(@user.name)
        expect(page).to have_current_path(users_path)
      end.to change(User, :count).by(-1)
    end
  end
end
# rubocop:enable Metrics/BlockLength
