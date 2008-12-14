require File.dirname(__FILE__) + '/../spec_helper'

describe "DmForum::Main (controller)" do
  
  # Feel free to remove the specs below
  
  before :all do
    Merb::Router.prepare { add_slice(:DmForum) } if standalone?
  end
  
  after :all do
    Merb::Router.reset! if standalone?
  end
  
  it "should have access to the slice module" do
    controller = dispatch_to(DmForum::Main, :index)
    controller.slice.should == DmForum
    controller.slice.should == DmForum::Main.slice
  end
  
  it "should have an index action" do
    controller = dispatch_to(DmForum::Main, :index)
    controller.status.should == 200
    controller.body.should contain('DmForum')
  end
  
  it "should work with the default route" do
    controller = get("/dm-forum/main/index")
    controller.should be_kind_of(DmForum::Main)
    controller.action_name.should == 'index'
  end
  
  it "should work with the example named route" do
    controller = get("/dm-forum/index.html")
    controller.should be_kind_of(DmForum::Main)
    controller.action_name.should == 'index'
  end
    
  it "should have a slice_url helper method for slice-specific routes" do
    controller = dispatch_to(DmForum::Main, 'index')
    
    url = controller.url(:dm_forum_default, :controller => 'main', :action => 'show', :format => 'html')
    url.should == "/dm-forum/main/show.html"
    controller.slice_url(:controller => 'main', :action => 'show', :format => 'html').should == url
    
    url = controller.url(:dm_forum_index, :format => 'html')
    url.should == "/dm-forum/index.html"
    controller.slice_url(:index, :format => 'html').should == url
    
    url = controller.url(:dm_forum_home)
    url.should == "/dm-forum/"
    controller.slice_url(:home).should == url
  end
  
  it "should have helper methods for dealing with public paths" do
    controller = dispatch_to(DmForum::Main, :index)
    controller.public_path_for(:image).should == "/slices/dm-forum/images"
    controller.public_path_for(:javascript).should == "/slices/dm-forum/javascripts"
    controller.public_path_for(:stylesheet).should == "/slices/dm-forum/stylesheets"
    
    controller.image_path.should == "/slices/dm-forum/images"
    controller.javascript_path.should == "/slices/dm-forum/javascripts"
    controller.stylesheet_path.should == "/slices/dm-forum/stylesheets"
  end
  
  it "should have a slice-specific _template_root" do
    DmForum::Main._template_root.should == DmForum.dir_for(:view)
    DmForum::Main._template_root.should == DmForum::Application._template_root
  end

end