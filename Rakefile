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
  temp = '../_tmp_output'
  rm_rf temp
  cp_r 'output', temp

  system 'git checkout gh-pages'

  rm_r '*'
  mv temp + '*', '.'

  system 'git add -A'
  system 'git commit -m "task: publish"'
  #system 'git push origin gh-pages'
  #system 'git checkout master'
end
