class DmForum::Discussions < DmForum::Application
  provides :xml, :yaml, :js
  before :find_forum

  def show(id)
    @discussion = Discussion.get(id)
    raise NotFound unless @discussion
    @comments = @discussion.comments
    display @discussion
  end

  def new
    only_provides :html
    @discussion = Discussion.new
    display @discussion
  end

  def edit(id)
    only_provides :html
    @discussion = Discussion.get(id)
    raise NotFound unless @discussion
    display @discussion
  end

  def create(discussion)
    @discussion = Discussion.new(discussion)
    @discussion.forum = @forum
    if @discussion.save
      redirect resource(@forum, @discussion), :message => {:notice => "Discussion was successfully created"}
    else
      message[:error] = "Discussion failed to be created"
      render :new
    end
  end

  def update(id, discussion)
    @discussion = Discussion.get(id)
    raise NotFound unless @discussion
    if @discussion.update_attributes(discussion)
       redirect resource(@forum, @discussion)
    else
      display @discussion, :edit
    end
  end

  def destroy(id)
    @discussion = Discussion.get(id)
    raise NotFound unless @discussion
    if @discussion.destroy
      redirect resource(@forum)
    else
      raise InternalServerError
    end
  end
  
  private
  
  def find_forum
    @forum = Forum.get(params[:forum_id])
  end

end # Discussions
