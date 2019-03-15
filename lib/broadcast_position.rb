class BroadcastPosition
  def initialize(position_gateway:)
    @position_gateway = position_gateway
  end
  def execute(*)
    @position_gateway.position
  end
end
