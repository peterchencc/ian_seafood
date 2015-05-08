class PacketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def index
    
    @packets = @product.packets
  end

  def show
    @packet = @product.packets.find( params[:id] )
  end

  def new
    @packet = @product.packets.build
    @packet.pictures.build if @packet.pictures.empty?
  end

  def create
    @packet = @product.packets.build( packet_params )

    if @packet.save
      redirect_to product_packets_path(@product)
    else
      render :new
    end
  end

  def edit
    @packet = @product.packets.find( params[:id] )
    @packet.pictures.build if @packet.pictures.empty?

  end

  def update
    
    @packet = @product.packets.find( params[:id] )

    if @packet.update( packet_params )
      redirect_to product_packets_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @packet = @product.packets.find( params[:id] )

    @packet.destroy

    redirect_to product_packets_path(@product)
  end

  protected

  def packet_params
    params.require(:packet).permit(:title, :content, :price, :video, :pictures_attributes => [:id, :title, :image, :_destroy] )
  end

  def set_product
    @product = Product.find(params[:product_id])  
  end
end
