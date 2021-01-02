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
		// pony_whole := ani.make_part(app.tick, ani.pony_body_pattern, [])
		pony_whole := ani.make_part(app.tick, ani.pony_body_pattern, []ani.Pattern_Type{})

		for i, strip in pony_whole.strips {
				app.tui.draw_text(pony_whole.origin.x + 3, pony_whole.origin.y + i + 1, strip.runes)
		}

		// Say
		sayings := [
				'hello'
				'world'
		]
		app.tui.draw_text(app.tui.window_width / 2, 1, sayings[rand.intn(sayings.len)])

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
