class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  acts_as_votable
  validates :body, :presence => true
  validates :title, :presence => true, :length => 5..140, :uniqueness => true
  validates :body, length: { minimum: 140 }
  validates :user_id, presence: true

  scope :default, -> { order('created_at DESC') }

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end

  scope :popular, -> { order('cached_votes_score DESC') }
  scope :active, -> { order('updated_at DESC') }

end
