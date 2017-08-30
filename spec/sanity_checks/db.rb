require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'dev_feeds.sqlite3'
)

class TokenizerTest < ActiveRecord::Base; end;
class FeedTest < ActiveRecord::Base; end;
