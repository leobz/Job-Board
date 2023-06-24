require 'uri'
require 'net/http'
require 'json'

class InvoicesController < ApplicationController
  skip_before_action :verify_authenticity_token

  API_KEY = Rails.configuration.x.opennode.api_key

  def create
    # Get request params
    customer_email = params["email"]
    job_id = params["job_id"]
    customer_name = params["company"]

    # Get OpenNode request config
    opennode_url = Rails.configuration.x.opennode.opennode_url
    my_host = Rails.configuration.x.app.my_host
    success_url  = "https://#{my_host}/jobs/#{job_id}?success=true"
    callback_url = "https://#{my_host}/invoices/webhook"

    # Build request
    url = URI(opennode_url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    headers = {
      'Content-Type': 'application/json',
      'Authorization': API_KEY
    }

    data = {
      amount: '0.5',
      description: 'Post Job',
      currency: 'USD',
      customer_email: customer_email,
      notif_email: customer_email,
      customer_name: customer_name,
      order_id: job_id,
      callback_url: callback_url,
      success_url: success_url,
      auto_settle: false,
      ttl: 10
    }

    request = Net::HTTP::Post.new(opennode_url, headers)
    request.body = data.to_json

    # Response
    response = http.request(request)
    parsed_body = JSON.parse(response.body)

    # Save invoice
    invoice = Invoice.new(
      id: parsed_body['data']['id'], 
      job_id: job_id,  
      description: parsed_body['data']['description'],                             
      status: parsed_body['data']['status'],                                  
      amount: parsed_body['data']['amount'],                                  
      fiat_value: parsed_body['data']['fiat_value'],
      currency: parsed_body['data']['currency'], 
      callback_url: parsed_body['data']['callback_url'],                            
      success_url: parsed_body['data']['success_url'],                             
      auto_settle: parsed_body['data']['auto_settle'],                             
      customer_email: customer_email,                          
      notif_email: parsed_body['data']['notif_email'],                             
      ttl: parsed_body['data']['ttl']
    )

    # Redirect to OpenNode invoice
    checkout_url = parsed_body['data']['hosted_checkout_url']

    respond_to do |format|
      if invoice.save
        format.html { redirect_to checkout_url, allow_other_host: true, status: :see_other }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end    
  end

  def webhook
    # Get request body
    request.body.rewind
    webhook_data = URI.decode_www_form(request.body.read).to_h

    # Validate request signature
    received_signature = webhook_data['hashed_order']
    calculated_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), API_KEY, webhook_data['id'])

    if received_signature != calculated_signature
      head :unauthorized
      return
    end

    # Get invoice request params
    invoice_id = webhook_data['id']
    status = webhook_data['status']

    # Update invoce
    invoice = Invoice.update(invoice_id, status: status)
  
    # Manage the webhook event depending of the status
    if invoice.status == 'paid'
      logger.info "Invoice #{invoice.id} status updated: paid"

      # Publish Job
      job = invoice.job
      job.published = true
      job.save

      logger.info "Job #{job.id} published successfully (#{job.title})"
    else
      logger.error "Invoice #{invoice.id} status updated: #{invoice.status}"
    end
  end
end