Stripe.api_key = Rails.application.credentials.dig(Rails.env.to_sym, :stripe_secret_key)
