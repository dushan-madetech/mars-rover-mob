describe DoCommand do
  class PositionGatewaySpy
    attr_accessor :position

    def retrieve
      @position.dup
    end

    def save(position)
      @position = position
    end
  end

  it 'can move the rover forward one when given the forward command' do
    position_spy = PositionGatewaySpy.new
    position_spy.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }
    command_gateways = {
      position_gateway: position_spy,
      motor_gateway: nil,
      sensor_gateway: nil
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      {
        commands: [:f]
      }
    )

    expect(position_spy.position).to eq(
      {
        position_x: 0,
        position_y: 1,
        direction: :north
      }
    )
  end

  it 'can move the rover forward two units when given two forward commands' do
    position_spy = PositionGatewaySpy.new
    position_spy.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }
    command_gateways = {
      position_gateway: position_spy,
      motor_gateway: nil,
      sensor_gateway: nil
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      {
        commands: [:f, :f]
      }
    )

    expect(position_spy.position).to eq(
      {
        position_x: 0,
        position_y: 2,
        direction: :north
      }
    )
  end

  it 'can move the rover forward three units when given three forward commands' do
    position_spy = PositionGatewaySpy.new
    position_spy.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }
    command_gateways = {
      position_gateway: position_spy,
      motor_gateway: nil,
      sensor_gateway: nil
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      {
        commands: [:f, :f, :f]
      }
    )

    expect(position_spy.position).to eq(
      {
        position_x: 0,
        position_y: 3,
        direction: :north
      }
    )
  end

  it 'can move the rover forward from a different starting position' do
    position_spy = PositionGatewaySpy.new
    position_spy.position = {
      position_x: 0,
      position_y: 1,
      direction: :north
    }
    command_gateways = {
      position_gateway: position_spy,
      motor_gateway: nil,
      sensor_gateway: nil
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      {
        commands: [:f]
      }
    )

    expect(position_spy.position).to eq(
      {
        position_x: 0,
        position_y: 2,
        direction: :north
      }
    )
  end
end
