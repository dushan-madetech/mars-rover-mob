class PositionGatewayFake
  attr_accessor :position

  def retrieve
    @position.dup
  end

  def save(position)
    @position = position
  end
end
