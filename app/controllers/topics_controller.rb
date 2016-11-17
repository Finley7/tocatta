class TopicsController < ApplicationController
  add_breadcrumb "Forums", :controller => 'sections', :action => 'index'

  def show


    @topic = Topic.find(params[:id])

    unless @topic.forum.permission_id.nil?
      if logged_in
        unless current_user.has_role(@topic.forum.permission_id)
          redirect_to :controller => 'forums', :action => 'index'
        end
      else
        redirect_to :controller => 'forums', :action => 'index'
      end
    end

    @replies = @topic.reply.paginate(:page => params[:page])
    @body = @topic.body.bbcode_to_html

    add_breadcrumb "#{@topic.forum.name}", :controller => 'forums', :action => 'show', :id => @topic.forum.id
    add_breadcrumb "#{@topic.title}", :action => 'show'
  end
end
