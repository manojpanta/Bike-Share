class Cart
  attr_reader :contents

  def initialize(initial_contents)
  @contents = initial_contents
  end

  def total_count
    contents.values.sum
  end

  def add_accessory(id)
    if @contents[id.to_s]
      @contents[id.to_s] = @contents[id.to_s] + 1
    else
      @contents[id.to_s] = 1
    end
  end

  def count_of(id)
    contents[id.to_s]
  end
end
