require 'entry'

class Content
  def initialize dir
    @dir = dir
  end

  def build output_dir
    entries.each { |x|
      x.build output_dir
    }
  end

  private

  def entries
    Pathname.glob(@dir + '*').map { |x| Entry.new x }
  end
end
