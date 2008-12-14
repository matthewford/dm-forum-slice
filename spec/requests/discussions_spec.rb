require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a discussion exists" do
  Discussion.all.destroy!
  request(resource(:discussions), :method => "POST", 
    :params => { :discussion => { :id => nil }})
end

describe "resource(:discussions)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:discussions))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of discussions" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a discussion exists" do
    before(:each) do
      @response = request(resource(:discussions))
    end
    
    it "has a list of discussions" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Discussion.all.destroy!
      @response = request(resource(:discussions), :method => "POST", 
        :params => { :discussion => { :id => nil }})
    end
    
    it "redirects to resource(:discussions)" do
      @response.should redirect_to(resource(Discussion.first), :message => {:notice => "discussion was successfully created"})
    end
    
  end
end

describe "resource(@discussion)" do 
  describe "a successful DELETE", :given => "a discussion exists" do
     before(:each) do
       @response = request(resource(Discussion.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:discussions))
     end

   end
end

describe "resource(:discussions, :new)" do
  before(:each) do
    @response = request(resource(:discussions, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@discussion, :edit)", :given => "a discussion exists" do
  before(:each) do
    @response = request(resource(Discussion.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@discussion)", :given => "a discussion exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Discussion.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @discussion = Discussion.first
      @response = request(resource(@discussion), :method => "PUT", 
        :params => { :discussion => {:id => @discussion.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@discussion))
    end
  end
  
end

