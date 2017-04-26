module Apige
  class Context
    def initialize(block)
      @block = block
      @scope = Scope.new
      @result = ''
    end

    def run!
      instance_exec &@block
    end

    def compile!
      @result << compile_head
      @result << "\n"
      compile(@scope)
      @result
    end

    def compile_head
      template = File.join(Apige.root_dir, Apige.templates[:head])
      erb = ERB.new(File.read(template))
      erb.filename = template
      erb.def_method(Apige::Config, 'render()')
      Apige.config.render()
    end

    def compile(scope)
      if !scope.children.empty?
        compile_api(scope)
        scope.children.map { |item| compile(item) }
      else
        template = File.join(Apige.root_dir, Apige.templates[scope.type])
        erb = ERB.new(File.read(template))
        erb.filename= template
        erb.def_method(Scope, 'render()')
        @result << scope.render()
        @result << "\n"
        compile_api(scope)
      end
    end

    def compile_api(scope)
      scope.apis.map { |wrapper|
        template =File.join(Apige.root_dir, Apige.templates[:api])
        erb = ERB.new(File.read(template))
        erb.filename= template
        erb.def_method(Api, 'render(level)')
        @result << wrapper.api.render(scope.level+1)
        @result << "\n"
      }
    end

    def default_api(method, path, block)
      @scope.apis << ApiWrapper.new(method, path, block, @scope)
    end


    def desc(description)
      @scope.description = description
    end

    def group(name, &block)
      scope = @scope.new_child(name, :group)
      @scope = scope
      instance_exec &block
      @scope = @scope.parent
    end

    def meta(data)
      @scope.meta = data
    end

    def resources(name, &block)
      @scope = @scope.new_child(name, :resources)
      instance_exec &block
      @scope = @scope.parent
    end

    def get(path, &block)
      default_api(:get, path, block)
    end

    def put(path, &block)
      default_api(:put, path, block)
    end

    def post(path, &block)
      default_api(:post, path, block)
    end

    def delete(path, &block)
      default_api(:delete, path, block)
    end

  end

end
