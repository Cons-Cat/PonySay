module animations
// import math

// pub struct Pony_State {
// pub:
// 		// head []Pony_Strip
// 		body []Pony_Strip
// 		offset Coord
// 		// leg []Pony_Strip
// 		// horn []Pony_Strip
// 		// tail []Pony_Strip
// }

pub struct Pony_Part {
pub:
		strips []Pony_Strip
		origin Coord
}

struct Pony_Strip{
pub:
		runes string
		offset byte
}

pub struct Coord {
pub:
		x byte
		y byte
}

fn strings_from_strip(strips []Pony_Strip) []string {
		mut strings := []string{}
		for s in strips {
				strings << s.runes
		}
		return strings
}

fn longest_str(strings []string) {
		// TODO: bool indexing is coming eventually.
		// unsafe {
				// mut str := []string{strings[(byte(strings[1].len > strings[0].len))]}
		// }
		mut str := [strings[
				 if strings[1].len > strings[0].len {1} else {0}
		]]
		str << strings[2..strings.len]
		longest_str(str)
}

pub fn (s_bot Pony_Part) stack_part(s_top Pony_Part) Pony_Part {
// pub fn (s_bot Pony_Part) stack_part() Pony_Part {
		// bot_strings := strings_from_strip(s_bot)
		// top_strings := strings_from_strip(s_top)

		// min_x := min(s_bot.origin.x, s_top.origin.x)
		// max_x := max(s_bot.origin.x + longest_str(bot_strings), s_top.origin.x + longest_str(top_strings))

		// min_y := min(s_bot.origin.y, s_top.origin.y)

		// return_str := []string{}
		/*
		for j in 0 .. s_bot.strips.len {
				return_str << ''
				for i in min_x .. max_x + longest_str(0, s_top.strips) {
					if i < s_bot.origin.x {
								return_str[j] + s_bot.strips[i]
						} else {
								return_str[j] + s_top.strips[i]
						}
				}
		}
		*/
		return s_bot
}

pub fn anim_head(tick byte) []Pony_Strip{
		frames := [
				[Pony_Strip{'^_|_^', 10},
				 Pony_Strip{'|(o o)', 9},
				 Pony_Strip{'/ |\\_/|_', 8},
				 Pony_Strip{'\\_/  |_/', 8}],

				[Pony_Strip{'/ ^|_^', 9}
				 Pony_Strip{'|(o o)',9},
				 Pony_Strip{'/ |\\__|_',8}
				 Pony_Strip{'\\__/  |_/',8}],

				[Pony_Strip{'/ ^/|^', 10}
				 Pony_Strip{'| ( o o)', 9}
				 Pony_Strip{'/ _\\)\\__|_', 8}
				 Pony_Strip{'\\__/  |\\_/', 8}],
		]
		// return frames[tick % 3]
		return frames[0]
}

pub fn anim_body(tick byte) []Pony_Strip {
		frames := [
				[Pony_Strip{'     __-',5},
				 Pony_Strip{' / ♥       :',1},
				 Pony_Strip{'| ♥  :   _ |',0},
				 Pony_Strip{' \\  |-!    |',1},
				 Pony_Strip{' |_\\ _\\  /_|',1}]
		]
		return frames[0]
}

/*
pub fn anim_leg(tick byte) []Pony_Strip {
		frames := [
				[Pony_Strip{'\\', 14},
				Pony_Strip{'|', 14},
				Pony_Strip{'\\', 15},
				Pony_Strip{'/_|', 13}]
		]
		return frames[0]
}

pub fn anim_horn(tick byte) []Pony_Strip {
		frames := [
				[Pony_Strip{' ', 1},
				 Pony_Strip{':', 1}],
				[Pony_Strip{'*', 1},
				 Pony_Strip{':', 1}],
				[Pony_Strip{'* *', 0},
				 Pony_Strip{'!', 1}],
				[Pony_Strip{'*', 1},
				 Pony_Strip{'*:*', 0}],
				[Pony_Strip{' ', 0},
				 Pony_Strip{'*!*', 0}]
		]
		return frames[tick % 5]
}
*/
