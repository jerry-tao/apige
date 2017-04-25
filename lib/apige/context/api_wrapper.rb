module Apige
  class Context
    class ApiWrapper
      def initialize(method, path, block)
        @api = Api.new
        api.method = method
        api.path = path
        api.origin_params = []
        api.required = []
        @block = block
        api.response_value = instance_exec &block
      end

      def api
        @api
      end

      def required(*argv)
        api.required = api.required.concat(argv).uniq
      end

      def params(*argv)
        api.origin_params = api.origin_params.concat(argv).uniq
      end

      def meta(data)
        api.meta = data
      end

      def desc(argv)
        api.desc = argv
      end

      def title(argv)
        api.title = argv
      end
    end
  end
end