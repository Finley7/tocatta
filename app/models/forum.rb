class Forum < ActiveRecord::Base
  belongs_to :section
  has_many :topics

  def last_topic(id)
    @topic = Topic.order(lastpost_date: :desc).where(forum_id: id).first(1)
  end
end
