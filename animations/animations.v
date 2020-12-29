module animations

pub struct Pony_State {
		pub:
		tick byte
		head []Pony_Strip
}

struct Pony_Strip{
pub:
		runes string
		offset i8
}

pub fn anim_head(tick byte) []Pony_Strip{
		head_frames := [
				[Pony_Strip{'^_|_^', 2},
				 Pony_Strip{'|(o o)', 1},
				 Pony_Strip{'/ |\\_/|_', 0},
				 Pony_Strip{'\\_/  |_/', 0}],

				[Pony_Strip{'/ ^|_^', 1}
				 Pony_Strip{'|(o o)',1},
				 Pony_Strip{'/ |\\__|_',0}
				 Pony_Strip{'\\__/  |_/',0}
				]
		]
		return head_frames[tick % 2]
}
