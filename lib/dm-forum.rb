if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  load_dependency 'merb-slices', '1.0.4'
  Merb::Plugins.add_rakefiles "dm-forum/merbtasks", "dm-forum/slicetasks", "dm-forum/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :dm-forum
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:dm_forum][:layout] ||= :dm_forum
  
  # All Slice code is expected to be namespaced inside a module
  module DmForum
    
    # Slice metadata
    self.description = "DmForum, provides a basic DataMapper forum"
    self.version = "0.0.1"
    self.author = "Matthew Ford"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
      DataMapper.auto_migrate!
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(DmForum)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :dm_forum_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      scope.resources :forums do |f|
        f.resources :discussions do |d|
          d.resources :comments
        end
      end
      # example of a named route
      # the slice is mounted at /dm-forum - note that it comes before default_routes
      scope.match('/').to(:controller => 'forums', :action => 'index').name(:forum_home)
      # enable slice-level default routes by default
      # scope.default_routes
    end
    
  end
  
  # Setup the slice layout for DmForum
  #
  # Use DmForum.push_path and DmForum.push_app_path
  # to set paths to dm-forum-level and app-level paths. Example:
  #
  # DmForum.push_path(:application, DmForum.root)
  # DmForum.push_app_path(:application, Merb.root / 'slices' / 'dm-forum')
  # ...
  #
  # Any component path that hasn't been set will default to DmForum.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  DmForum.setup_default_structure!
  
  # Add dependencies for other DmForum classes below. Example:
  # dependency "dm-forum/other"
  
  dependency "merb-assets", "1.0.4"
  dependency "merb-helpers", "1.0.4"
  dependency "merb-action-args", "1.0.4"
  require "iconv"
  
  begin
    require 'rdiscount'
    BlueCloth = RDiscount
  rescue LoadError
    require 'bluecloth'
  end
  
end