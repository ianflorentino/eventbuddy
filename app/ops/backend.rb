require 'subroutine'

module Backend
  class Op < Subroutine::Op

    class_attribute :atomic

    class << self

      def atomic!
        self.atomic = true
      end

      def atomic?
        !!self.atomic
      end

    end

    attr_reader :current_user

    def initialize(*args)
      params = args.extract_options!
      @current_user = args[0]
      super(params)
    end

    def atomic(only_if_class_desires = false)
      should_be_atomic = !only_if_class_desires || self.class.atomic?
      if should_be_atomic
        ActiveRecord::Base.transaction do
          yield
        end
      else
        yield
      end
    end

    def bool(input)
      !!(input.to_s =~ /^(t|1|y|ok)/)
    end

    def patch_attributes(model)
      params.keys.each do |k|
        model.send("#{k}=", send(k)) if model.respond_to?("#{k}=")
      end
    end

  end
end
