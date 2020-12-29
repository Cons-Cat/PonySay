module animations

pub struct Pony_State {
		pub:
		head []Pony_Strip
		body []Pony_Strip
}

struct Pony_Strip{
pub:
		runes string
		offset i8
}

pub fn anim_head(tick byte) []Pony_Strip{
		frames := [
				[Pony_Strip{'^_|_^', 2},
				 Pony_Strip{'|(o o)', 1},
				 Pony_Strip{'/ |\\_/|_', 0},
				 Pony_Strip{'\\_/  |_/', 0}],

				[Pony_Strip{'/ ^|_^', 1}
				 Pony_Strip{'|(o o)',1},
				 Pony_Strip{'/ |\\__|_',0}
				 Pony_Strip{'\\__/  |_/',0}],

				[Pony_Strip{'/ ^/|^', 2}
				 Pony_Strip{'| ( o o)', 1}
				 Pony_Strip{'/ _\\)\\__|_', 0}
				 Pony_Strip{'\\__/  |\\_/', 0}],
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
