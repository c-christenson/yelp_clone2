require 'rails_helper'

feature 'restaurants' do 

  context 'no restaurants' do 

    scenario 'it should display a link to add a restaurant' do 
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'  
    end
  end

  context 'adding a restaurant' do 
    before do 
      Restaurant.create(name: 'KFC')
    end

    scenario 'it should display a restaurant name when added' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

end

