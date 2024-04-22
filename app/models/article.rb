class Article < ApplicationRecord
  has_many :article_tags
  has_many :tags, through: :article_tags
  before_validation :generate_slug, on: :create

  validates :title, presence: true, length: { maximum: 32 }
  validates :slug, presence: true
  validates :description, presence: true, length: { maximum: 128 }
  validates :body, presence: true, length: { maximum: 512 }

  private

  def generate_slug
    slug_base = title.parameterize
    self.slug = "#{slug_base}-#{Time.now.to_i}"
  end
end
