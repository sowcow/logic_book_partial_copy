task default: :build

$:.unshift 'lib'

task :build do
  require 'content'

  content_dir = Pathname 'content'
  content = Content.new content_dir

  rm_rf 'output'
  content.build Pathname 'output'
end
