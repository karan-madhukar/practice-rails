class ReactionsController < ApplicationController

  def create 
    @reaction = Reaction.new(reaction_params)

    if @reaction.save
      if @reaction.react == true
        @reaction 
        respond_to :js
      else
        redirect_to :root_path , flash: { danger: "something goes wrong!" } 
      end
    else
      redirect_to :root_path , flash: { danger: "something goes wrong!" } 
    end
  end


  def like_update
    @reaction = Reaction.find(params[:id])
    update_like(@reaction)
  end
  
   
  def dislike_update
    @reaction = Reaction.find(params[:id])
    update_dislike(@reaction)
  end

private
  def reaction_params
    params.require(:reaction).permit(:user_id, :article_id, :react)
  end
end
