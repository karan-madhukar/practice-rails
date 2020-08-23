module ReactionsHelper

  def update_dislike(reaction)
    if reaction.react == false
      if reaction.update(react: nil)
        respond_to :js
      end
    elsif reaction.react == true
      if reaction.update(react: false)
        respond_to :js
      end
    else
      if reaction.update(react: false)
        respond_to :js
      end
    end
  end

  def update_like(reaction)
    if reaction.react == true
      if reaction.update(react: nil)
        respond_to :js
      end
    elsif reaction.react == false
      if reaction.update(react: true)
        respond_to :js
      end
    else
      if reaction.update(react: true)
        respond_to :js
      end
    end
  end
end
