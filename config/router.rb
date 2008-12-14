# This file is here so slice can be testing as a stand alone application.

Merb::Router.prepare do
  # identify Forum  => :slug, Discussion => :slug do
    resources :forums do
      resources :discussions do
        resources :comments
      end
    end
  # end
end