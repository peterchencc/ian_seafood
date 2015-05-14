class ApiV1::OrdersController < ApiController

  def create
    @order = Order.new( name: params[:name],
                        phone: params[:phone],
                        address: params[:address],
                        email: params[:email],                       
                        payment_method: params[:payment_method], 
                        amount: params[:amount] )

    Array(params[:line_items]).each do |line_item|
      @order.line_items.build( :product_id => line_item[:product_id],
                               :packet_id => line_item[:packet_id],
                               :subtotal => line_item[:subtotal],
                               :qty => line_item[:qty] )
    end

    @order.user = current_user

    if  @order.save
        render :json => { :message => "OK", :order_id => @order.id, :pay_url => checkout_order_url(@order) }
    else
        render :json => { :errors => @order.errors.full_messages }, :status => 400
    end
  end

end