class IdeasController < ApplicationController
  before_filter :require_authentication, only: [:new, :create]
  before_filter :require_admin, only: [:edit, :update, :destroy]
  
  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(params[:idea])
    if @idea.save
      redirect_to @idea, :notice => "Pomysł został zapisany."
    else
      render :action => 'new'
    end
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update_attributes(params[:idea])
      redirect_to @idea, :notice  => "Pomysł został zapisany."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to ideas_url, :notice => "Pomysł został usunięty."
  end
  
  private
    
  def require_authentication
    redirect_to new_user_session_url unless user_signed_in?
  end

  def require_admin
    redirect_to new_user_session_url unless current_user.try(:admin)
  end
end
