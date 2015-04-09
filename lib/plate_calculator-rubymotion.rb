# encoding: utf-8
begin
  if ENV['osx']
    require 'motion/project/template/osx'
  else
    require 'motion/project/template/ios'
  end
rescue LoadError
  require 'motion/project'
end

lib_dir_path = File.dirname(File.expand_path(__FILE__))
Motion::Project::App.setup do |app|
  gem_files = Dir.glob(File.join(lib_dir_path, "plate_calculator/*.rb"))
  app.files.unshift(gem_files)
end
