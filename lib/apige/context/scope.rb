module Apige
  class Context
    class Scope
      def initialize(name='', type='top', parent=nil, level=1)
        @level = level
        @apis = []
        @name = name
        @type = type
        @parent = parent
        @children = []
        @description = ''
      end

      attr_accessor :meta, :children, :apis, :description, :name,:level, :type, :parent

      def new_child(name, type)
        scope = Scope.new(name, type, self, @level+1)
        @children << scope
        scope
      end

    end
  end
end