class Topic < ApplicationRecord

  belongs_to :forum
  belongs_to :author, :class_name => 'User'
  belongs_to :lastposter, :class_name => 'User'
  belongs_to :editor, :class_name => 'User', :foreign_key => :edit_by

  has_many :reply, :foreign_key => :topic_id

  validates :title, :presence => true, :length => { :in => 5..75 }
  validates :body, :presence => true, :length => { :in => 10..65535 }

end
