# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
Rails.logger = Le.new('994cab80-3d33-4ecf-a56a-9108f93971d0', :debug => true, :local => true)
