require "test_doubles/position_gateway_fake"

describe BroadcastPosition do
  class ChangePositionStub
    attr_reader :position

    def initialize(new_position:)
      @position = new_position
    end

    def execute
      @position
    end
  end

  let(:position_fake) {PositionGatewayFake.new}
  let(:broadcast_position) {BroadcastPosition.new(position_gateway: position_fake)}

  it 'can broadcast a starting position' do
    position_fake.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }

    expect(broadcast_position.execute({})).to eq(
      {
        position_x: 0,
        position_y: 0,
        direction: :north
      }
    )
  end

  it 'can broadcast position after changing position' do
    position_fake.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }

    change_position_stub = ChangePositionStub.new(new_position:
      {
        position_x: 3,
        position_y: 5,
        direction: :north
      }
    )

    position_fake.save(change_position_stub.execute)

    expect(broadcast_position.execute({})).to eq(
      {
        position_x: 3,
        position_y: 5,
        direction: :north
      }
    )
  end

  it 'can broadcast position after changing direction' do
    position_fake.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }

    change_position_stub = ChangePositionStub.new(new_position:
      {
        position_x: 0,
        position_y: 0,
        direction: :east
      }
    )

    position_fake.save(change_position_stub.execute)

    expect(broadcast_position.execute({})).to eq(
      {
        position_x: 0,
        position_y: 0,
        direction: :east
      }
    )
  end

  it 'can broadcast position after changing position and direction' do
    position_fake.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }

    change_position_stub = ChangePositionStub.new(new_position:
      {
        position_x: -3,
        position_y: -7,
        direction: :west
      }
    )

    position_fake.save(change_position_stub.execute)

    expect(broadcast_position.execute({})).to eq(
      {
        position_x: -3,
        position_y: -7,
        direction: :west
      }
    )
  end
end
