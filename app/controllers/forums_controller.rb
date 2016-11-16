class ForumsController < ApplicationController
  add_breadcrumb "Forums", :controller => 'sections', :action => 'index'

  def index
    redirect_to :controller => 'sections', :action => 'index'
  end

  def add
  end

  def show
    @forum = Forum.find(params[:id])


    add_breadcrumb "#{@forum.name}", :action => 'show'
  end
end
