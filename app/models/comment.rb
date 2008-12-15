class Comment
  include DataMapper::Resource
  
  property :id, Serial
  property :body, Text
  property :body_html, Text
  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :discussion
  # belongs_to :user  
  
  before :save, :markdown_text
  before :save, :update_discussion
  
  def markdown_text
    attribute_set(:body_html, Markdown.new(body).to_html) unless body.blank?
  end
  
  def update_discussion
    self.discussion.update_attributes(:updated_at => Time.now)
  end
  
end
