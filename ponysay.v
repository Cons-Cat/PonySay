import term
import term.ui as tui
import animations as ani
import rand

struct App {
mut:
		tui      &tui.Context = 0
		redraw   bool
		tick byte
}

fn init(x voidptr) {
		mut a := &App(x)
		a.redraw = true
}

fn event(e &tui.Event, x voidptr) {
		mut app := &App(x)
		app.redraw = true
}

fn frame(x voidptr) {
		mut app := &App(x)
		if !app.redraw { return }
		app.tick = (app.tick + 1) % 256
		app.tui.clear()

		// Pony
		pony_state := ani.Pony_State {
				head: ani.anim_head(app.tick)
				body: ani.anim_body(app.tick)
		}
		for i, strip in pony_state.body {
				app.tui.draw_text(1 + strip.offset, i + 6, strip.runes)
		}
		for i, strip in pony_state.head {
				app.tui.draw_text(9 + strip.offset, i + 3, strip.runes)
		}

		// Say
		sayings := [
				'hello'
				'world'
		]
		app.tui.draw_text(app.tui.window_width / 2, 0, sayings[rand.intn(sayings.len)])

		app.tui.reset()
		app.tui.flush()
}

fn main() {
		mut app := &App{}
		app.tui = tui.init(
				user_data: app,
				init_fn:  init,
				event_fn: event,
				frame_fn: frame

				hide_cursor: true
				frame_rate: 20
		)

		app.tui.run()
}
