require "apige/version"
require "apige/config"
require "apige/context"
require "apige/context/api"
require "apige/context/scope"
require "apige/context/api_wrapper"

module Apige

  class << self
    def config
      @config ||= Config.new
    end

    def configure
      yield(config)
    end

    def run(&block)
      @context = Context.new(block)
      @context.run!
    end

    def context
      @context
    end

    def compile!(root_dir)
      config.root_dir = root_dir
      doc_dir = File.join(root_dir, 'docs', Apige.config.version.to_s)
      FileUtils.mkdir_p(doc_dir)
      Dir["#{root_dir}/apis/*.rb"].each { |r|
        api = File.basename r, '.rb'
        require r
        File.open(File.join(doc_dir, api+'.md'), 'w') do |file|
          file.write Apige.context.compile!
        end
      }
    end

    def templates
      config.templates
    end

    def root_dir
      config.root_dir
    end
  end

end
