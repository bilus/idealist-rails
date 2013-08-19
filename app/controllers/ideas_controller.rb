class IdeasController < ApplicationController
  before_filter :require_authentication, only: [:new, :create, :vote]
  before_filter :require_admin, only: [:edit, :update, :destroy]
  
  def index
    @ideas = Idea.find_with_reputation(:votes, :all, order: "votes DESC")
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = Idea.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @idea = current_user.ideas.build(params[:idea])
    
    if @idea.save
      respond_to do |format|
        format.html { redirect_to @idea, :notice => "Pomysł został zapisany." }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.js { render template: 'ideas/new.js.erb' }
      end
    end
  end

  def edit
    @idea = Idea.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update_attributes(params[:idea])
      respond_to do |format|
        format.html { redirect_to @idea, :notice  => "Pomysł został zapisany." }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.js { render template: 'ideas/edit.js.erb' }
      end
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to ideas_url, :notice => "Pomysł został usunięty."
  end
  
  def vote
    value = params[:type] == "up" ? 1 : -1
    @idea = Idea.find(params[:id])
    @idea.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Dziękujemy za Twój głos."
  end
  
  private
    
  def require_authentication
    redirect_to new_user_session_url unless user_signed_in?
  end

  def require_admin
    redirect_to new_user_session_url unless current_user.try(:admin)
  end
end
