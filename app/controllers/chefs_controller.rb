class ChefsController < ApplicationController
  before_action :get_chef, only: [:show, :edit, :update]

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Welcome #{@chef.chefname} to MyRecipes App"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = "You account was updated successfully"
      redirect_to @chef
    else
      # redirect_to action: :edit, id: @chef.id
      render :edit    # this will make the url look wrong. '/chefs/:id', not '/chefs/:id/edit'
    end
  end

  private

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def get_chef
    @chef = Chef.find(params[:id])
  end
end
