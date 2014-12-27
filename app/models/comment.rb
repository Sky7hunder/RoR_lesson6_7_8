class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates_presence_of :body

  has_ancestry

  after_create do
    self.post.touch
  end
end
