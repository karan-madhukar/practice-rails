class CategoriesController < ApplicationController
  before_action :require_admin

  def new
    @category = Category.new
  end

  def create
    @category = Category.new
    @category.name = params[:category][:name]
    
    if @category.save
      redirect_to new_category_path, flash: { success: "category created succesfully"}
    else
      render "new"
    end
  end
  
end
