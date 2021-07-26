require_relative 'view/ruby2d'
require_relative 'model/state'
require_relative 'actions/actions'

class App
  def initialize
    @state = Model::initial_state
  end

  def start
    @view = View::Ruby2dView.new(self)
    times_thread = Thread.new { init_timer(@view)}
    @view.start(@state)
    times_thread.join
  end

  def send_action(action,params)
    # :change_direction, Model::Direction::up
    new_state = Actions.send(action, @state, params)
    if new_state.hash != @state
      @state = new_state
      @view.render(@state)
    end
  end

  private

  def init_timer(view)
    loop do
      speed = 0.5
      if @state.game_finished
        puts 'juego finalizado'
        puts "puntaje: #{@state.snake.positions.length}"
        break
      end
      @state = Actions::move_snake(@state)
      view.render(@state)
      sleep speed
      speed += 0.5
    end
  end
end

app = App.new
app.start
