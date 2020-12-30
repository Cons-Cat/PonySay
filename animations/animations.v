module animations
import math

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
		x i8
		y i8
}

fn strings_from_strip(strips []Pony_Strip) []string {
		mut strings := []string{}
		for s in strips {
				strings << s.runes
		}
		return strings
}

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
		// TODO: Bug report
		// ver_span := int(math.max(s_bot.origin.y + s_bot.strips.len, s_top.origin.y + s_top.strips.len) - math.min(s_bot.origin.y, s_top.origin.y))

		// maxy := if s_bot.origin.y + s_bot.strips.len > s_top.origin.y + s_top.strips.len {s_bot.origin.y + s_bot.strips.len} else {s_top.origin.y + s_top.strips.len}
		// miny := if s_bot.origin.y < s_top.origin.y { s_bot.origin.y } else { s_top.origin.y }
		// ver_span := int(maxy) - int(miny)

		ver_span := 30
		hor_span := 20

		// off_bx := if s_top.origin.x < s_bot.origin.x { s_bot.origin.x - s_top.origin.x } else { 0 }
		// off_tx := if s_bot.origin.x < s_top.origin.x  { s_top.origin.x - s_bot.origin.x } else { 0 }

		off_by := if s_top.origin.y < s_bot.origin.y { s_bot.origin.y - s_top.origin.y } else { 0 }
		off_ty := if s_bot.origin.y > s_top.origin.y { s_bot.origin.y - s_top.origin.y } else { 0 }

		mut return_strips := []Pony_Strip{}
		for j in 0 .. ver_span {
				// mut temp_str := ' '.repeat(s.offset)
				mut temp_str := ''
				println(s_bot.origin.y)

				for i in 0 .. hor_span {
						// TODO: Make ticket for returing bytes
						// temp_str += s_bot.strips[j].runes[i]

						// TODO: Make ticket for assigning byte a negative value
						if j >= s_top.origin.y + off_ty && j < s_top.origin.y + off_ty + s_top.strips.len
								&& i >= s_top.origin.x && i < s_top.origin.x + s_top.strips[j].runes.len
						{
								temp_str += s_top.strips[s_top.origin.y + off_ty + j].runes[i-8].str()
						} else if j >= s_bot.origin.y + off_by && j < s_bot.origin.y + off_by + s_bot.strips.len && i >= s_bot.origin.x && i < s_bot.origin.x + s_bot.strips[j-off_by].runes.len {
								// temp_str += ' '.repeat(s_bot.strips[j].offset)
								temp_str += s_bot.strips[j-off_by].runes[i].str()
						} else {
								temp_str += 'x'
						}
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
				[Pony_Strip{'  ^_|_^', 2},
				 Pony_Strip{' |(o o)', 1},
				 Pony_Strip{'/ |\\_/|_', 0},
				 Pony_Strip{'\\_/  |_/', 0}],

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
