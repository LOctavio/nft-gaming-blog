class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  def most_recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  private

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
