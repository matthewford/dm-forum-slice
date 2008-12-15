class Discussion
  include DataMapper::Resource
  
  property :slug, String, :key => true
  property :title, String
  property :body, Text
  property :body_html, Text
  property :locked, Boolean, :default => false
  property :sticky, Boolean, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :forum, :class_name => "Forum"
  # belongs_to :user  
  
  has n, :comments

  before :valid?, :create_slug
  before :save, :markdown_text
  
  def markdown_text
    attribute_set(:body_html, Markdown.new(body).to_html) unless body.blank?
  end
  
  def create_slug
    throw :halt if title.blank?
    attribute_set(:slug, escape(title))
  end
  
  # rails parameterize inspired
  def escape(string)
    result = Iconv.iconv('ascii//translit//IGNORE', 'utf-8', string).to_s
    result.gsub!(/[^\x00-\x7F]+/, '')  # Remove anything non-ASCII entirely (e.g. diacritics).
    result.gsub!(/[^\w_ \-]+/i,   '')  # Remove unwanted chars.
    result.gsub!(/[ \-]+/i,      '-')  # No more than one of the separator in a row.
    result.gsub!(/^\-|\-$/i,      '')  # Remove leading/trailing separator.
    result.downcase
  end

end
