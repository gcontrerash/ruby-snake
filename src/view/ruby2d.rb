require 'ruby2d'

module View
  class Ruby2dView

    def initialize (app)
      @pixel_size = 50
      @app = app
    end

    def start(state)
      extend Ruby2D::DSL
      set(
          title: 'snake || GRECIA',
          width: @pixel_size * state.grid.cols,
          height: @pixel_size * state.grid.rows
         )
         on :key_down do |event|
            # a key was prssed
           handle_key_event(event)
            puts event.key
         end

         show
    end

    def render(state)
      render_food(state)
      render_snake(state)
    end

    private

    def render_food(state)
      extend Ruby2D::DSL
      close if state.game_finished

      @food.remove if @food
      food = state.food
      @food = Square.new(
        x: food.col * @pixel_size,
        y: food.row * @pixel_size,
        size: @pixel_size,
        color: 'yellow'
      )
    end

    def render_snake(state)
      @snake_positions.each(&:remove) if @snake_positions
      extend Ruby2D::DSL
      snake = state.snake
      @snake_positions = snake.positions.map do |position|
        Square.new(
          x: position.col * @pixel_size,
          y: position.row * @pixel_size,
          size: @pixel_size,
          color: 'green'
        )
      end
    end

    def handle_key_event(event)
      case event.key
      when 'up'
        #cambiar direccion hacia arriba
        @app.send_action(:change_direction, Model::Direction::UP)
      when 'down'
        #cambiar direccion hacia abajo
        @app.send_action(:change_direction, Model::Direction::DOWN)
      when 'left'
        #cambiar direccion hacia izquierda
        @app.send_action(:change_direction, Model::Direction::LEFT)
      when 'right'
        #cambiar direccion hacia derecha
        @app.send_action(:change_direction, Model::Direction::RIGHT)
      end
    end
  end
end
