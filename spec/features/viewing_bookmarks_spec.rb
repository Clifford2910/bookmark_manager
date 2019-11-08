feature 'Viewing bookmarks' do

  let(:bookmark_manager) { double :BookmarkManager }

  scenario 'visiting the index page' do
    visit('/')
    expect(page).to have_content "Bookmark Manager"
  end

  scenario 'viewing the bookmark list' do
    con = PG.connect(dbname: 'bookmark_manager_test')

    Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers')
    Bookmark.create(url: 'http://www.google.com', title: 'Google')
    Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')

    visit('/bookmarks')

    expect(page).to have_link("Makers", href: 'http://www.makersacademy.com')
    expect(page).to have_link("Google", href: 'http://www.google.com')
    expect(page).to have_link("Destroy All Software", href: 'http://www.destroyallsoftware.com')
  end
end
