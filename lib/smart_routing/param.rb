module SmartRouting
  class Param
    attr_reader :val
    def initialize(context, param_name, param_opts, options)
      @val = options.fetch(param_name) do
        raise KeyError, ":#{param_name} must be supplied. #{param_opts[:message]}" unless param_opts[:optional]
        param_opts[:default] if param_opts[:default]
      end
      context.instance_variable_set("@#{param_name}", @val)
    end
  end
end
