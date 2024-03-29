module animations
import math

struct Pony_Part {
		pub:
		strips []Pony_Strip
		origin Coord
		joints []Joint
}

struct Joint {
		part Pony_Part
		pivot Coord
}

struct Pony_Strip {
		pub:
		runes string
		// offset byte
}

struct Coord {
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
		ver_span := int(math.max(s_bot.origin.y + s_bot.strips.len, s_top.origin.y + s_top.strips.len) - math.min(s_bot.origin.y, s_top.origin.y))
		hor_span := int(math.max(s_bot.origin.x + s_bot.strips[0].runes.len, s_top.origin.x + s_top.strips[0].runes.len) - math.min(s_bot.origin.x, s_top.origin.x)) + 1
		off_y:= if s_top.origin.y < 0 { -s_top.origin.y } else { 0 }
		off_x:= if s_top.origin.x < 0 { -s_top.origin.x } else { 0 }

		mut return_strips := []Pony_Strip{}
		for j in 0 .. ver_span {
				mut temp_str := ''
				println(s_bot.origin.y)

				for i in 0 .. hor_span {
						// TODO: Make ticket for returing bytes
						//   temp_str += s_bot.strips[j].runes[i]
						// TODO: Make ticket for assigning byte a negative value
						// TODO: Make ticket for indexing string with heart.

						if j >= s_top.origin.y + off_y
								&& j < s_top.origin.y + off_y+ s_top.strips.len
								&& i >= s_top.origin.x + off_x
								&& i < s_top.origin.x + off_x+ s_top.strips[j - s_top.origin.y - off_y].runes.len
						{
								temp_str += s_top.strips[j - s_top.origin.y - off_y].runes[i - s_top.origin.x - off_x].str()
						} else if
								j >= s_bot.origin.y + off_y
								&& j < s_bot.origin.y + off_y+ s_bot.strips.len
								&& i >= s_bot.origin.x + off_x
								&& i < s_bot.origin.x + off_x+ s_bot.strips[j-off_y].runes.len {
										temp_str += s_bot.strips[j-off_y].runes[i - off_x].str()
						} else {
								temp_str += ' '
						}
				}

				return_strips << Pony_Strip {
						runes: temp_str.clone()
						// offset: 0
				}
		}

		return Pony_Part {
				strips: return_strips
				origin: s_bot.origin
				joints: []Joint{}
		}
}

// TODO: Ticket? Type in its own signature after byte arg..
// type Pattern_Type = fn (tick byte, joints []Pattern_Type) int
// type Pattern_Type = fn (byte, Pattern_Type) Pony_Part

type Pattern_Type = fn (joints []Pattern_Type, tick byte) Pony_Part

pub fn make_part(tick byte, joint_patterns []Pattern_Type, pattern Pattern_Type) Pony_Part {
		return pattern(joint_patterns, tick)
}

pub fn pony_body_pattern (pattern []Pattern_Type, tick byte) Pony_Part {
		return Pony_Part {
				strips: pony_body_strips(tick)
				origin: pony_body_origin(tick)
				joints: pony_body_joints(tick)
		}
}

fn pony_body_strips(tick byte) []Pony_Strip {
		frames := [
				[Pony_Strip{'     __-'},
				 // Pony_Strip{' / ♥       :'},
				 Pony_Strip{' / *       :'},
				 // Pony_Strip{'| ♥  :   _ |'},
				 Pony_Strip{'| *  :   _ |'},
				 Pony_Strip{' \\  |-!    |'},
				 Pony_Strip{' |_\\ _\\  /_|'}]
		]
		return frames[0]
}

fn pony_body_origin(tick byte) Coord {
		return Coord{0,0}
}

fn pony_body_joints(tick byte) []Joint{
		// TODO: Hard code a joints array.
		return []
}

/*pub fn anim_head(tick byte) []Pony_Strip {
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

pub fn anim_leg(tick byte) []Pony_Strip {
		frames := [
				[Pony_Strip{' \\', 1},
				 Pony_Strip{' |', 1},
				 Pony_Strip{'  \\', 2},
				 Pony_Strip{'/_|', 0}]
		]
		return frames[0]
}

pub fn anim_horn(tick byte) []Pony_Strip {
		frames := [
				[Pony_Strip{'', 1},
				 Pony_Strip{' :', 1}],
				[Pony_Strip{' *', 1},
				 Pony_Strip{' :', 1}],
				[Pony_Strip{'* *', 0},
				 Pony_Strip{' !', 1}],
				[Pony_Strip{' *', 1},
				 Pony_Strip{'*:*', 0}],
				[Pony_Strip{' ', 0},
				 Pony_Strip{'*!*', 0}]
		]
		return frames[tick % 5]
}

pub fn anim_tail(tick byte) []Pony_Strip {
		frames := [
				[Pony_Strip{'     __', 1},
				 Pony_Strip{'    /  \\', 1},
				 Pony_Strip{'    |', 2},
				 Pony_Strip{'|\\_|', 0},
				 Pony_Strip{'|', 0},
				 Pony_Strip{' \\_' 0}]
		]
		return frames[0]
}
