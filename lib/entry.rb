require 'content'

require 'fileutils'
require 'slim'
require 'kramdown'

class Entry
  def initialize dir
    @dir = dir
    @base = @dir.basename.to_s
  end

  def build dir #output_dir #/build_dir
    dir += @base
    mkpath dir
    put_page into: dir
    put_image into: dir
  end

  def path
    @base
  end
  def title
    content.title
  end

  private

  def put_page into: raise
    file = into + 'index.html'
    file.write page
  end

  def put_image into: raise
    images.each { |x|
      x.copy into: into
    }
  end

  def images
    Pathname.glob(@dir + '*.png').map { |x| Image.new x }
  end
  class Image
    def initialize file
      @file = file
    end

    def copy into: raise
      FileUtils.cp @file, into
    end
    def relative_path
      @file.basename
    end
  end

  def page
    template.render content
  end

  def template
    TEMPLATE
  end

  def content
    @_content ||=
    Content.new(File.read content_file)
    .tap { |x|
      them = images
      x.send :define_singleton_method, :images do them end
    }
  end
  class Content
    def initialize string
      @header = YAML.load string[HEADER, 0]
      @rest = string.sub HEADER, ''
    end
    HEADER = /---\n(.*)---\n/m

    def title
      @header.fetch 'title'
    end

    def body
      Kramdown::Document.new(@rest).to_html
    end
  end

  def content_file
    @dir + 'content.md'
  end

  include FileUtils

TEMPLATE = Slim::Template.new { <<slim }
doctype 5
html
  head
    title = title
    meta charset='utf-8'
    sass:
      @import vendor/bourbon/bourbon

      $bg: #eee5d6
      $w: 664px
      $fg: #46342a

      a
        color: rgba(200, 0, 0, 0.7)
      //mix(mix($bg, $fg), black)
      //maroon

      html, body, div
        margin: 0
        padding: 0

      html
        background-color: $bg
        color: $fg

      body
        width: $w
        margin: 0 auto
        font-family: $lucida-grande

      h1
        text-align: center
        font-family: $monospace

      .image-frame
        box-shadow: inset 0px 0px 12px 16px $bg
        img
          position: relative
          z-index: -1
  body
    - images.each do |image|
      .image-frame
        img src=image.relative_path

    h1 = title

    #text
      == body
slim
end
