class Article < ApplicationRecord
  has_many :article_tags
  has_many :tags, through: :article_tags
  before_save :generate_slug
  validates :title, presence: true, length: { maximum: 32 }
  validates :description, presence: true, length: { maximum: 128 }
  validates :body, presence: true, length: { maximum: 512 }
  def generate_slug
    slug_base = title.parameterize
    self.slug = "#{slug_base}-#{id}"
  end
end
