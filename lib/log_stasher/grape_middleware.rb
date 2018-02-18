require 'logstasher'
module LogStasher
  class GrapeMiddleware < Grape::Middleware::Base

    def call!(env)
      @env = env
      before
      @app_response = @app.call(@env)
      after || @app_response
    end

    def before
      start_time
    end

    def after
      stop_time
      process_action
      nil
    end

    private

    def total_runtime
      ((stop_time - start_time) * 1000).round(2)
    end

    def start_time
      @start_time ||= Time.now
    end

    def stop_time
      @stop_time ||= Time.now
    end

    def process_action(*args)
      raw_payload = {
          :api          => env['api.endpoint'].options[:for].to_s,
          :api_action   => env['api.endpoint'].options[:path].first,
          :params       => env['rack.request.form_hash'] || env['grape.routing_args'].except(:format, :route_info,:version),
          :format       => env['api.endpoint'].header['Content-Type'],
          :method       => env['api.endpoint'].options[:method].first,
          :path         => env['PATH_INFO'],
          :duration     => total_runtime,
          :version      => env['grape.routing_args'][:route_info].instance_variable_get(:@options)[:version],
          :resource     => 'API',
          :remote_ip    => (env["action_dispatch.remote_ip"].to_s if env["action_dispatch.remote_ip"]),
          current_user: env[:current_user_email],
          status: response.status,
          response: (response.body.to_s unless (response.status==201 || response.status==200))
      }
      raw_payload[:params]['avatar'][:tempfile] = nil if raw_payload[:params]['avatar'].present?
      LogStasher.clear_request_context
      LogStasher.logger << ::LogStash::Event.new(raw_payload).to_json + "\n"
    end
  end
end

