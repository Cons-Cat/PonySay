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
		pony_whole := ani.Pony_Part {
				strips: ani.anim_body(app.tick)
				origin: ani.Coord {
						byte(app.tui.window_width / 2 - 12),
						5
				}
		}.join_parts(ani.Pony_Part(
				strips: ani.anim_head(app.tick)
				origin: ani.Coord{0,0}))

		for i, strip in pony_whole.strips {
				app.tui.draw_text(pony_whole.origin.x, pony_whole.origin.y + i, strip.runes)
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
