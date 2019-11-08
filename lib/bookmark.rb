require 'pg'

class Bookmark

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'bookmark_manager_test')
    else
      con = PG.connect(dbname: 'bookmark_manager')
    end
    result = con.exec("SELECT * FROM bookmarks")
    result.map do |row|
      Bookmark.new(id: row['id'], title: row['title'], url: row['url'])
    end
  end

  def self.create(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'bookmark_manager_test')
    else
      con = PG.connect(dbname: 'bookmark_manager')
    end
    result = con.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end
end
