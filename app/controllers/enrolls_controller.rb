class EnrollsController < ApplicationController
  def new
    @plans = Plan.all
    @payment_options = PaymentOption.all
  end
end
