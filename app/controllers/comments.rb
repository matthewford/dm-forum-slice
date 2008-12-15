class DmForum::Comments < DmForum::Application
  # provides :xml, :yaml, :js
  
  before :find_objects

  def index
    @comments = Comment.all
    display @comments
  end

  def new
    only_provides :html
    @comment = Comment.new
    display @comment
  end

  def edit(id)
    only_provides :html
    @comment = Comment.get(id)
    raise NotFound unless @comment
    display @comment
  end

  def create(comment)
    @comment = Comment.new(comment)
    @comment.discussion = @discussion
    if @comment.save
      redirect resource(@forum, @discussion), :message => {:notice => "Comment was successfully created"}
    else
      message[:error] = "Comment failed to be created"
      render :new
    end
  end

  def update(id, comment)
    @comment = Comment.get(id)
    raise NotFound unless @comment
    if @comment.update_attributes(comment)
       redirect resource(@forum, @discussion)
    else
      display @comment, :edit
    end
  end

  def destroy(id)
    @comment = Comment.get(id)
    raise NotFound unless @comment
    if @comment.destroy
      redirect resource(@forum, @discussion)
    else
      raise InternalServerError
    end
  end
  
  private
  
  def find_objects
    @forum = Forum.get(params[:forum_id])
    @discussion = Discussion.get(params[:discussion_id])
  end

end # Comments
