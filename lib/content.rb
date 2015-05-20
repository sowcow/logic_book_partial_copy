require 'entry'
require 'index'

class Content
  def initialize dir
    @dir = dir
  end

  def build output_dir
    entries.each { |x|
      x.build output_dir
    }
    index.build output_dir
  end

  private

  def entries
    @_entries ||=
      Pathname.glob(@dir + '*').map { |x| Entry.new x }
  end

  def index
    Index.new entries
  end
end
