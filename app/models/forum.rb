class Forum < ActiveRecord::Base
  belongs_to :section
  has_many :topics
  has_many :subforums, :class_name => 'Forum', :foreign_key => :is_subforum

  def last_topic(id)

    @topic = Topic.order(lastpost_date: :desc).where(forum_id: id).first(1)


  end
end
