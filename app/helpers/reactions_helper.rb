module ReactionsHelper

  def update_dislike(reaction)
    if reaction.react == false
      if reaction.update(react: nil)
        redirect_to root_path, flash: { success: "you removed your reaction from an article!" }
      end
    elsif reaction.react == true
      if reaction.update(react: false)
        redirect_to root_path, flash: { success: "changed reaction! disliked an article!" }
      end
    else
      if reaction.update(react: false)
        redirect_to root_path, flash: { success: "you disiked an article!" }
      end
    end
  end

  def update_like(reaction)
    if reaction.react == true
      if reaction.update(react: nil)
        redirect_to root_path, flash: { success: "you removed your reaction from an article!" }
      end
    elsif reaction.react == false
      if reaction.update(react: true)
        redirect_to root_path, flash: { success: "changed reaction! liked an article!" }
      end
    else
      if reaction.update(react: true)
        redirect_to root_path, flash: { success: "you liked an article!" }
      end
    end
  end
end
