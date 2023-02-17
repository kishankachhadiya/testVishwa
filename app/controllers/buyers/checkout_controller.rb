class Buyers::CheckoutController < ApplicationController

  before_action :get_job, only: [:new, :create]

  def create

    token = params[:stripeToken]

    puts "===========token==============#{token.inspect}"

    customer = Stripe::Customer.create(
      source: token,
      email: current_user.email,
    )
    puts "---------------------customer-------------#{customer.inspect}"

    source = Stripe::Customer.retrieve_source(customer.id, customer.default_source)
    puts "#{customer.inspect}"
    puts "#{source.inspect}"

    sources = Stripe::Source.create({
                                      type: 'ach_credit_transfer',
                                      currency: 'usd',
                                      owner: {
                                        email: current_user.email,
                                      },
                                    })

    puts "::::::::::::::::::::::::::source:::::::::::::::::::#{sources.inspect}"

    charge = Stripe::Charge.create({
                                     customer: customer.id,
                                     amount: '99',
                                     currency: 'usd',
                                     description: 'Example charge',
                                     source: source.id,
                                   })
    puts "+++++++++++++++charge+++++++++++++++#{charge.inspect}"

    if charge
      @payment = PaymentHistory.new(job_id: @job.id,
                                    price: charge.amount,
                                    charge_id: charge.id,
                                    buyer_id: current_user.id,
                                    customer_id: customer.id,
                                    source_id: sources.id,
                                    token_id: token,
                                    email: current_user.email,
                                    seller_id: @job.user_id)
      if @payment.save
        redirect_to buyers_homes_path, :notice => 'Payment Successfully.'

      else
        puts "-----------------#{@payment.errors.full_messages}"
      end
    end
  end

  private

  def get_job
    @job = Job.find(params[:id])
  end

end
