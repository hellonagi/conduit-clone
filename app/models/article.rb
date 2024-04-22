class Article < ApplicationRecord
  has_many :article_tags
  has_many :tags, through: :article_tags
  before_save :generate_slug

  def generate_slug
    slug_base = title.parameterize
    random_number = rand(1..999)
    self.slug = "#{slug_base}-#{random_number}"
  end
end
