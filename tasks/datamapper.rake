task :autoupgrade do
  require File.expand_path File.join(File.dirname(__FILE__), '..', '/', 'schema.rb')
  DataMapper.auto_upgrade!
end
