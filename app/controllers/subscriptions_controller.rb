class SubscriptionsController < ApplicationController
  def new

  end

  def create
    stripe_token = params[:stripeToken]
    customer = Stripe::Customer.create(
      source: stripe_token,
      plan: "plan_DJiwGf0hxuvrDT",
      email: current_user.email,
    )
    current_user.customer_id = customer.id
    current_user.billing_status = "subscribed"
    current_user.save!
    redirect_to "/"
  end
end
