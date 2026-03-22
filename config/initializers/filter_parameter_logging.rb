# Be sure to restart your server when you modify this file.

# Configure parameters which will be filtered from the log file. Use this to limit dissemination of
# temporary access tokens, self-signed certs, passwords, and other sensitive information.
Rails.application.config.filter_parameters += [
  :passw, :email, :secret, :token, :_key, :crypt, :salt, :certificate, :otp, :ssn
]
