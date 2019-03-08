describe 'Mars Rover' do
  class InMemoryPositionGateway
  end

  class MotorGateway
  end

  let(:position_gateway) { InMemoryPositionGateway.new }
  let(:motor_gateway) { MotorGateway.new }

  it 'can move forward 1 unit' do
    command_gateways = {
      position_gateway: position_gateway,
      motor_gateway: motor_gateway,
      sensor_gateway: nil
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      {
        commands: [:f]
      }
    )

    broadcast_position = BroadcastPosition.new(position_gateway: position_gateway)

    expect(broadcast_position.execute({})).to eq(
      {
        position_x: 0,
        position_y: 1,
        direction: :north
      }
    )
  end
end
