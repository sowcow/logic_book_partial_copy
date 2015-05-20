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
    ul
      - entries.each do |entry|
        li
          a href=entry.path = entry.title
slim
end
