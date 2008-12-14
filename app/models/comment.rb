class Comment
  include DataMapper::Resource
  
  property :id, Serial
  property :body, Text
  property :body_html, Text
  
  belongs_to :discussion
  # belongs_to :user  
  
  before :save, :markdown_text
  
  def markdown_text
    attribute_set(:body_html, Markdown.new(body).to_html) unless body.blank?
  end
  
end
