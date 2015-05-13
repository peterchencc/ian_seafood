class AboutsController < ApplicationController
  before_action :authenticate_user!
  def index
    @abouts = About.all
  end

  def show
    @about = About.find(params[:id])
  end

  def new
    @about = About.new
  end

  def create
    @about = About.new( about_params )

    if @about.save

      flash[:notice] = "新增成功"

      redirect_to abouts_path
    else
      render :action => :index
    end

  end

  def edit
    @about = About.first
  end

  def update
    @about = About.first

    if @about.update( about_params )

      flash[:notice] = "編輯成功"

      redirect_to edit_about_path
    else
      render :action => :edit
    end
  end


  protected

  def about_params
    params.require(:about).permit(:title, :content, :phone, :email, :atm_account)
  end
end
