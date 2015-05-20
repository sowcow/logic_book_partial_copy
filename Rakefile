task default: :build

$:.unshift 'lib'

task :build do
  require 'content'

  content_dir = Pathname 'content'
  content = Content.new content_dir

  rm_rf 'output'
  content.build Pathname 'output'
end


task :pub => :publish

task :publish do
  system 'git checkout gh-pages'

  here = Pathname '*'
  Pathname.glob(here).each { |file|
    next if file.basename == 'output'
    rm_r file
  }
  mv 'output/*', '.'
  rm_r 'output'

  system 'git add -A'
  system 'git commit -m "task: publish"'
  system 'git push origin gh-pages'
  system 'git checkout master'
end
