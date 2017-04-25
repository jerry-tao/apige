require "active_support/all"
module Apige
  class Config
    include ActiveSupport::Configurable
    config_accessor :date, :meta, :version, :templates, :author, :root_dir
  end
end