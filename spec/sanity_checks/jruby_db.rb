require 'jdbc/sqlite3'
Jdbc::SQLite3.load_driver

require 'active_record'
require 'activerecord-jdbcsqlite3-adapter'

ActiveRecord::Base.establish_connection(
    adapter: 'jdbcsqlite3',
    database: 'dev_feeds.sqlite3'
)

class TokenizerTest < ActiveRecord::Base; end;
class FeedTest < ActiveRecord::Base; end;
