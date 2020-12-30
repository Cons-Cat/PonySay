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

struct Pony_Strip {
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

// fn longest_str(strings []string) string {
fn longest_str_len(strings []string) byte {
		// TODO: bool indexing is coming eventually.
		// unsafe {
				// mut str := []string{strings[(byte(strings[1].len > strings[0].len))]}
		// }
		mut str := [strings[
				 if strings[1].len > strings[0].len {1} else {0}
		]]
		if strings.len > 2 {
				str << strings[2..strings.len]
				longest_str_len(str)
		}
		return byte(str[0].len)
}

pub fn (s_bot Pony_Part) join_parts (s_top Pony_Part) Pony_Part {
// pub fn (s_bot Pony_Part) stack_part() Pony_Part {
		// bot_strings := strings_from_strip(s_bot)
		// top_strings := strings_from_strip(s_top)

		// min_x := min(s_bot.origin.x, s_top.origin.x)
		// max_x := max(s_bot.origin.x + longest_str(bot_strings), s_top.origin.x + longest_str(top_strings))

		// min_y := min(s_bot.origin.y, s_top.origin.y)

		// mut m := map[string]int

		// TODO: Refactor
		mut strs_bot := []string{}
		for s in s_bot.strips {
				// m[s.runes] = s.runes.len
				strs_bot << s.runes
		}
		mut strs_top := []string{}
		for s in s_top.strips {
				// m[s.runes] = s.runes.len
				strs_top << s.runes
		}
		// longest_len := longest_str_len(m.keys())
		longest_len_bot := longest_str_len(strs_bot) - 1
		longest_len_top := longest_str_len(strs_top) - 1
		// longest_len := longest_str_len(strs)
		// longest_len := 1

		mut return_strips := []Pony_Strip{}
		for j, s in s_bot.strips {
				mut temp_str := ' '.repeat(s.offset)

				for i in 0 .. s_bot.strips[j].runes.len {
				// for i in 0 .. (longest_len - s.offset) {
						// for i in 0 .. 10 {
						// if i < s_top.origin.x + longest_len_top {
						if i >= s_top.origin.x && i <= s_top.origin.x + longest_len_top {
								// TODO: Make ticket
								// temp_str += '$s_bot.strips[j].runes[i]'
								temp_str += s_bot.strips[j].runes[i].str()
						} else {
								// temp_str += s_top.strips[j].runes[i].str()
								// temp_str += string(rune(s_top.strips[j].runes[i]))
						}
						// temp_str += s_bot.strips[j].runes[i].str()
				}

				return_strips << Pony_Strip {
						runes: temp_str.clone()
						offset: 0
				}
		}

		return Pony_Part {
				strips: return_strips
				origin: s_bot.origin
		}
}

pub fn anim_head(tick byte) []Pony_Strip {
		frames := [
				[Pony_Strip{'^_|_^', 10},
				 Pony_Strip{'|(o o)', 9},
				 Pony_Strip{'/ |\\_/|_', 8},
				 Pony_Strip{'\\_/  |_/', 8}],

				[Pony_Strip{'/ ^|_^', 9}
				 Pony_Strip{'|(o o)',9},
				 Pony_Strip{'/ |\\__|_',8},
				 Pony_Strip{'\\__/  |_/',8}],

				[Pony_Strip{'/ ^/|^', 10}
				 Pony_Strip{'| ( o o)', 9}
				 Pony_Strip{'/ _\\)\\__|_', 8},
				 Pony_Strip{'\\__/  |\\_/', 8}],
		]
		// return frames[tick % 3]
		return frames[0]
}

pub fn anim_body(tick byte) []Pony_Strip {
		frames := [
				[Pony_Strip{'__-',5},
				 Pony_Strip{'/ ♥       :',1},
				 Pony_Strip{'| ♥  :   _ |',0},
				 Pony_Strip{'\\  |-!    |',1},
				 Pony_Strip{'|_\\ _\\  /_|',1}]
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
