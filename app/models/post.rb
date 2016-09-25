class Post < ActiveRecord::Base

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user, counter_cache: true

  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 40 }
  validates :title, presence: true, length: { in: 1..150 }
  validates :category, presence: true

  delegate :username, :avatar_url, to: :user, prefix: true

  default_scope -> { order(created_at: :desc) }
  self.scope :category_count, -> (category) { where(category: category).count }

  def username
    user_username
  end

  def avatar_url
    user_avatar_url
  end

  def image_content
    post = Nokogiri::HTML(content)
    post_img = post.css('img').first
    post_img.nil? ? first_str(post) : first_str(post, post_img)
  end

  private

  def first_str(object, img = nil)
    spans = object.css('span, p')
    returned_span = ""
    return_span_with_image = ""
      spans.each do |span|
        returned_span = span
        break if span.text.length >= 50
      end

    img.nil? ? returned_span.to_html : return_span_with_image << img.to_html << returned_span.to_html
  end
end