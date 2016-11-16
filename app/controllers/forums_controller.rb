class ForumsController < ApplicationController
  add_breadcrumb "Forums", :controller => 'sections', :action => 'index'

  def index
    redirect_to :controller => 'sections', :action => 'index'
  end

  def add
  end

  def show
    @forum = Forum.find(params[:id])

    unless @forum.permission_id.nil?
      if logged_in
        unless current_user.has_role(@forum.permission_id)
          redirect_to :controller => 'forums', :action => 'index'
        end
      else
        redirect_to :controller => 'forums', :action => 'index'
      end
    end

    add_breadcrumb "#{@forum.name}", :action => 'show'
  end
end
