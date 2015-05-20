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
<a href="https://github.com/sowcow/logic_book_partial_copy"><img style="position: absolute; top: 0; left: 0; border: 0;" src="https://camo.githubusercontent.com/567c3a48d796e2fc06ea80409cc9dd82bf714434/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f6c6566745f6461726b626c75655f3132313632312e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_left_darkblue_121621.png"></a>
ribbon
  end
end
