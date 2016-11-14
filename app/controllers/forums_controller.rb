class ForumsController < ApplicationController
  def index
    @forums = Forum.joins(:section)
  end

  def add
  end

  def view
  end
end
