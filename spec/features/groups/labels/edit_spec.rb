require 'spec_helper'

feature 'Edit group label', feature: true do
  given(:user)  { create(:user) }
  given(:group) { create(:group) }
  given(:label) { create(:group_label, group: group) }

  background do
    group.add_owner(user)
    login_as(user)
    visit edit_group_label_path(group, label)
  end

  scenario 'update label with new title' do
    fill_in 'label_title', with: 'new label name'
    click_button 'Save changes'

    expect(current_path).to eq(root_path)
    expect(label.reload.title).to eq('new label name')
  end
end
