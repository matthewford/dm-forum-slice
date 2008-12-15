class Forum
  include DataMapper::Resource
  
  property :slug, String, :key => true
  property :title, String
  property :description, Text
  property :description_html, Text
  property :position, Integer
  property :created_at, DateTime
  property :updated_at, DateTime
  
  has n, :discussions
  # belongs_to :user  
  
  before :valid?, :create_slug
  before :save, :markdown_text
  
  def markdown_text
    throw :halt if description.blank?
    self.description_html = Markdown.new(description).to_html
  end
  
  def create_slug
    throw :halt if title.blank?
    self.slug = escape(title)
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
