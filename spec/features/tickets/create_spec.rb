require 'spec_helper'

feature "Creating tickets" do
  let(:user) {create :user}
  let(:project) {create :project}
  
  before do
    define_permission user, "view", project
    sign_in_as user
    
    click_link project.name
    click_link "Create Ticket"
  end
  
  scenario "creating a ticket" do
    fill_in "Title", with: "Bad project"
    fill_in "Description", with: "So so baaaaaaaaad"
    click_button "Create Ticket"
    
    expect(page).to have_content "Ticket has been created"
    within '#ticket #author' do
      expect(page).to have_content user.email
    end
  end
  
  scenario "creating ticket with invalid attributes" do
    click_button "Create Ticket"
    
    expect(page).to have_content "Ticket has not been created"
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Description can't be blank"
  end
  
  scenario "where description is less than 10 chars" do
    fill_in "Title", with: "Internet Explorer"
    fill_in "Description", with: "Sucks"
    click_button "Create Ticket"
    
    expect(page).to have_content "Ticket has not been created"
    expect(page).to have_content "Description is too short"
  end
end