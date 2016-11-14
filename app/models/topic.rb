class Topic < ApplicationRecord

  belongs_to :forum
  belongs_to :author, :class_name => 'User'
  belongs_to :lastposter, :class_name => 'User'
  belongs_to :editor, :class_name => 'User', :foreign_key => :edit_by


end
