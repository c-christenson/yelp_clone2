require 'rails_helper'

feature 'restaurants' do 

  context 'no restaurants' do 

    scenario 'it should display a link to add a restaurant' do 
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'  
    end
  end

  context 'displaying a restaurant' do 
    before do 
      Restaurant.create(name: 'KFC')
    end

    scenario 'it should display a restaurant name when added' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'adding a restaurant' do

    scenario 'it should have a form when add a restaurant in clicked' do 
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end

  end

  context 'viewing a restaurant' do 

    let!(:kfc){Restaurant.create(name: 'KFC')}

    scenario 'should be able to view a restaurant' do 
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content('KFC')
      expect(current_path).to eq "/restaurants/#{kfc.id}"

    end

  end

  context 'updating a restaurant' do 

    before {Restaurant.create(name: 'KFC')}

    scenario 'a user can edit the restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant' 
       expect(page).not_to have_content('KFC')
      expect(page).to have_content('Kentucky Fried Chicken')
    end

  end

  context 'deleting a restaurant' do

    before {Restaurant.create(name: 'KFC')}

    scenario 'a user can delete a restaurant' do 
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content('KFC')
      expect(page).to have_content 'Restaurant deleted succesfully'
    end

  end

end

