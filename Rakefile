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

task :publish => :build do
  system 'git add -A'
  system 'git commit -m "task: publish"'

  temp = '../_tmp_output'
  rm_rf temp
  cp_r 'output', temp

  system 'git checkout gh-pages'

  system 'rm -rf *'
  system "mv #{temp}/* ."

  system 'git add -A'
  system 'git commit -m "task: publish"'
  system 'git push origin gh-pages'
  system 'git checkout master'
end
