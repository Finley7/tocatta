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

  def create
    if logged_in
      @forum = Forum.find(params[:id])

      if @forum.nil?
        raise Exception.new("Forum niet gevonden")
      end

      if current_user.has_role(@forum.permission_id)
        @topic = Topic.new

        if request.post?
          topic_params = params.require(:topic).permit(:title, :body)

          @topic = Topic.new(topic_params)

          @topic.forum_id = @forum.id
          @topic.author_id = current_user.id
          @topic.lastposter_id = current_user.id
          @topic.slug = params[:topic][:title].slugify
          @topic.lastpost_date = DateTime.current

          if @topic.save
            flash[:message] = "Je topic is geplaatst!"
            flash[:type] = "success"

            redirect_to :action => 'show', :slug => @topic.slug, :id => @topic.id
          else
            flash[:message] = "Er ging iets fout"
            flash[:type] = "alert"
          end

        end
      else
        raise Exception.new("Not enough privileges")
      end
    else
      raise Exception.new("Not logged in")
    end

    add_breadcrumb "#{@forum.name}", :controller => 'forums', :action => 'show', :id => @forum.id
    add_breadcrumb "Maak nieuw topic", :action => 'create'
  end
end
