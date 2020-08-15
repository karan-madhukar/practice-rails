class ReactionsController < ApplicationController

  def create 
    @reaction = Reaction.new(reaction_params)

    if @reaction.save
      if @reaction.react == true
        redirect_to root_path, flash: { success: "you liked an article!" }
      else
        redirect_to root_path, flash: { success: "you disliked an article!" }
      end
    else
      redirect_to root_path, flash: { danger: "you reacted on an article!" }
    end
  end

  def update
    @reaction = curret_user.reactions.find_by(article: article)
    if @reaction.react == true
      if @reaction.update(react: nil)
        redirect_to root_path, flash: { success: "you removed your reaction from an article!" }
      end
    elsif @reaction.react == false
      if @reaction.update(react: true)
        redirect_to root_path, flash: { success: "you liked an article!" }
      end
    else
      if @reaction.update(react: true)
        redirect_to root_path, flash: { success: "you liked an article!" }
      end
    end
  end

  private
  def reaction_params
    params.require(:reaction).permit(:user_id, :article_id, :react)
  end
end
