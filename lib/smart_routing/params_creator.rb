module SmartRouting
  class ParamsCreator
    def initialize(context, params, options)
      @context = context
      @params = params
      @options = options
    end

    def create
      @params.each do |param_name, param_opts|
        SmartRouting::Param.new(@context, param_name, param_opts, @options)
      end
      self
    end

    def to_hash
      res = {}
      @params.each do |param_name, param_opts|
        res[param_name.to_sym] = @context.instance_variable_get("@#{param_name}")
      end
      res
    end
  end
end
