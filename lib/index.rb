require 'slim'

class Index
  def initialize entries
    @entries = entries
  end

  def build dir
    file = dir + 'index.html'
    File.write file, content
  end

  private
  attr_reader :entries

  def content
    template.render self
  end

  def template
    TEMPLATE
  end

TEMPLATE = Slim::Template.new { <<slim }
doctype 5
html
  head
    meta charset='utf-8'
  body
    == ribbon
    ul
      - entries.each do |entry|
        li
          a href=entry.path = entry.title
slim

  def ribbon
<<ribbon
<a href="https://github.com/you"><img style="border: 0;" src="https://camo.githubusercontent.com/c6625ac1f3ee0a12250227cf83ce904423abf351/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f6c6566745f677261795f3664366436642e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_left_gray_6d6d6d.png"></a>
ribbon
  end
end
