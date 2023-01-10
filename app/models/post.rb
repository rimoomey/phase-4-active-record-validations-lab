class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w[Fiction Non-Fiction] }
  validate :must_be_clickbait

  PATTERNS = [
    /You Won't/,
    /Secret/,
    /Top [0-9]+/,
    /Guess/
  ]

  def must_be_clickbait
    return unless title.present?
    return unless PATTERNS.none? { |pattern| pattern.match title }

    errors.add(:title, 'Title must be clickbait')
  end
end
