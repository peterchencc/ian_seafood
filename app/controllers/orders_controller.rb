class OrdersController < ApplicationController

  before_action :authenticate_user!, :except => :checkout
  before_action :check_admin, :except => :checkout

  def index
    @orders = Order.page(params[:page]).per(7)
  end

  def show
    @order = Order.find params[:id]
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new_from_cart current_cart, order_params
    if @order.save
      current_cart.clear
      redirect_to @order
    else
      render :new
    end
  end

  def checkout    
    order = Order.find params[:order_id]
    if order.paid?
      redirect_to order, alert: '已經付過款'
    else

      return_url = if Rails.env.production?
        "http://www.inseason.tw/allpay/return"
      else
        'http://requestb.in/14x3b9x1'
      end

      trade = order.trades.create!
      allpay = Allpay.new
      @checkout_params = {
        MerchantID: allpay.merchant_id,
        MerchantTradeNo: trade.trade_number,
        MerchantTradeDate: Time.now.strftime('%Y/%m/%d %H:%M:%S'),
        PaymentType: :aio,
        TotalAmount: order.total.round,
        TradeDesc: :'My Cart',
        ItemName: order.line_items.map{ |i| "#{i.product.name} x #{i.qty}" }.join('#'),
        ChoosePayment: order.payment_method,
        ReturnURL: return_url,
        OrderResultURL: allpay_result_url
      }
      @checkout_params[:CheckMacValue] = allpay.make_mac(@checkout_params)
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :payment_method, :phone, :email)
  end

end
