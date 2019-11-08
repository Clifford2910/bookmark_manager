feature 'new bookmark' do
  scenario 'add a new bookmark' do
    visit('/bookmarks/new')
    fill_in('url', with: "http://testbookmark.com")
    fill_in('title', with: "Test Bookmark")
    click_button('Submit')
    expect(page).to have_link('Test Bookmark', href: 'http://testbookmark.com')
  end
end
