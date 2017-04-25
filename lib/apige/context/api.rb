module Apige
  class Context
    class Api
      attr_accessor :method, :path, :origin_params, :required, :response_value, :title, :desc, :meta

      def params
        Array((origin_params+required).uniq).map do |item|
          {name: item, required: required.index(item)!=nil}
        end
      end
    end
  end
end