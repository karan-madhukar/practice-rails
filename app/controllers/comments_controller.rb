class CommentsController < ApplicationController
  before_action :require_user
   
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to article_path(@comment.article)
    else
      redirect_to article_path, flash: { danger: "check the inputs"}
    end
  end

  private 

  def comment_params
    params.require(:comment).permit(:user_id, :article_id, :comment)
  end

end
