require 'allpay'
class Trade < ActiveRecord::Base
  serialize :params, JSON
  belongs_to :order
  validate :check_mac, on: :update
  after_initialize :generate_trade_number, if: :new_record?

  def self.find_and_initialize_by_allpay params = {}
    trade = self.find_by(trade_number: params[:MerchantTradeNo])
    trade.paid = params['RtnCode'] == '1'
    trade.params = params
    trade
  end

private

  def check_mac
    allpay = Allpay.new
    errors.add(:params, 'wrong mac value') unless allpay.check_mac(params)
  end

  def generate_trade_number
    self.trade_number = SecureRandom.hex(3)
  end
end