# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

require_relative Rails.root.join('lib', 'gis_operations.rb')
