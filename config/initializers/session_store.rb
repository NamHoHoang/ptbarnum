# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ptbarnum_session',
  :secret      => '69e4caa5ba0283db104923a92d385283b44f37de6eaa3246718005ce7f7b2aee95b2688d5d78eeef0429ece448799dd28a4e86f1891812f4c9e8e9e496091b2a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
