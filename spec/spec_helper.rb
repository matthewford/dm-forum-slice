require 'rubygems'
require 'merb-core'
require 'merb-slices'
require 'spec'

# Add dm-forum.rb to the search path
Merb::Plugins.config[:merb_slices][:auto_register] = true
Merb::Plugins.config[:merb_slices][:search_path]   = File.join(File.dirname(__FILE__), '..', 'lib', 'dm-forum.rb')

# Require dm-forum.rb explicitly so any dependencies are loaded
require Merb::Plugins.config[:merb_slices][:search_path]

# Using Merb.root below makes sure that the correct root is set for
# - testing standalone, without being installed as a gem and no host application
# - testing from within the host application; its root will be used
Merb.start_environment(
  :testing => true, 
  :adapter => 'runner', 
  :environment => ENV['MERB_ENV'] || 'test',
  :session_store => 'memory'
)

require 'dm-sweatshop'


module Merb
  module Test
    module SliceHelper
      
      # The absolute path to the current slice
      def current_slice_root
        @current_slice_root ||= File.expand_path(File.join(File.dirname(__FILE__), '..'))
      end
      
      # Whether the specs are being run from a host application or standalone
      def standalone?
        Merb.root == ::DmForum.root
      end
      
    end
  end
end

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)
  config.include(Merb::Test::SliceHelper)
end


## dm-sweatshop factories
Forum.fix {
	{
		:title => /\w+/.gen,
		:description =>  /\w+/.gen
	}
}

Discussion.fix {
	{
		:title => /\w+/.gen,
		:body => /\w+/.gen
	}
}

Comment.fix {
	{
		:body => /\w+/.gen
	}
}

# slug helper, rails parameterize inspired
def escape(string)
  result = Iconv.iconv('ascii//translit//IGNORE', 'utf-8', string).to_s
  result.gsub!(/[^\x00-\x7F]+/, '')  # Remove anything non-ASCII entirely (e.g. diacritics).
  result.gsub!(/[^\w_ \-]+/i,   '')  # Remove unwanted chars.
  result.gsub!(/[ \-]+/i,      '-')  # No more than one of the separator in a row.
  result.gsub!(/^\-|\-$/i,      '')  # Remove leading/trailing separator.
  result.downcase
end