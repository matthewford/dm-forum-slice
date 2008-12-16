require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Forum do
	
	before :all do
		DataMapper.auto_migrate!
		@forum = Forum.gen	
	end

	#Attributes
	[:slug,
   :title,
   :description,
   :description_html,
   :position,
   :created_at,
   :updated_at ].each do |attr|
		it "should have the attribute #{attr}" do
			@forum.respond_to?(attr).should be_true
		end
	end
	
	it "should have discussions" do
		3.times{@forum.discussions << @d = Discussion.gen}
		@forum.discussions.include?(@d).should be_true
	end
	
	it "should markdown the description" do
		Markdown.new(@forum.description).to_html.should == @forum.description_html
	end
	
	it "have a slug" do
		escape(@forum.title).should == @forum.slug
	end
	
end