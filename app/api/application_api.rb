require 'api/helpers'
#require 'api/custom_json_error_formatter'
require 'doorkeeper/grape/helpers'

class ApplicationAPI < Grape::API

  #################################
  #### CONTENT_TYPES AND FORMATTERS
  #################################
  content_type :json, 'application/json'
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers

  content_type :xml, 'application/xml'
  formatter :xml, proc { |object|
    if object.is_a?(Hash)
      object[object.keys.first].to_xml root: object.keys.first
    elsif object.is_a?(String)
      object
    else
      object.to_xml
    end
  }

  content_type :msgpack, 'application/x-msgpack'
  format :msgpack

  rescue_from ActiveRecord::RecordNotFound do |e|
    error!(e.message, 404)
  end

  ############
  #### LOGGING
  ############
  require 'log_stasher/grape_middleware'
  use LogStasher::GrapeMiddleware

  ############
  #### HELPERS
  ############
  helpers API::Helpers
  helpers Doorkeeper::Grape::Helpers
  helpers do
    def current_user
      return unless doorkeeper_token
      user = User.find(doorkeeper_token.resource_owner_id)
      env[:current_user_id] = user.id
      env[:current_user_email] = user.email
      user
    end

    def route_options
      env['api.endpoint'].options[:route_options]
    end

    def return_error(e, status_code)
      if !!e.try(:errors)
        message = e.errors.full_messages.to_sentence
      else
        message = e
      end
      
      error!(message, status_code)
    end

    def basic_authorize!(login)
      login = login
      block = Proc.new{ |source_app, api_key| source_app==login && Settings.http[source_app] && Settings.http[source_app] == api_key }
      @auth = Rack::Auth::Basic::Request.new(request.env)
      if @auth.provided? && @auth.basic?
        error!('Unauthorized', 401) unless block.call(*@auth.credentials)
      else
        error!('Unauthorized', 401)
      end
    end

  end

  ##############
  #### CALLBACKS
  ##############
  before do
    if !route_options[:skip_authorization]
      doorkeeper_authorize!
    elsif route_options[:basic_authorization]
      option = route_options[:basic_authorization] || 'mobile'
      basic_authorize!(option)
    end
  end

  ###########
  #### MOUNTS
  ###########
  mount ::V1::Base
end
