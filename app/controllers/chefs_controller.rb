class ChefsController < ApplicationController
  before_action :get_chef, only: [:show]

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

  private

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def get_chef
    @chef = Chef.find(params[:id])
  end
end
