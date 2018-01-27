module AwooUpdater
  def self.ensure_update(con)
    con.query "SET sql_notes = 0;"
    con.query "
CREATE TABLE IF NOT EXISTS archived_posts (
	post_id INTEGER NOT NULL PRIMARY KEY,
	board TEXT NOT NULL,
	title TEXT NOT NULL
);"
    con.query "ALTER DATABASE awoo DEFAULT CHARACTER SET 'utf8mb4';"
    con.query "ALTER TABLE archived_posts DEFAULT CHARACTER SET 'utf8mb4';"
    con.query "ALTER TABLE posts DEFAULT CHARACTER SET 'utf8mb4';"
    con.query "ALTER TABLE archived_posts CONVERT TO CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';"
    con.query "ALTER TABLE posts CONVERT TO CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';"
    con.query "SET sql_notes = 1;"
  end
  def self.userscript_pull()
    system("git -C #{File.dirname(__FILE__) + "/../../static/static/awoo-catalog"} pull")
  end
  def self.run(con)
    ensure_update(con)
    userscript_pull()
  end
end