module animations

pub struct Pony_State {
		pub:
		tick i8
		head []Rune_Strip
}

struct Rune_Strip{
pub:
		runes string
		offset i8
}

pub fn anim_head(tick i8) []Rune_Strip {
		head_frames := [
				[Rune_Strip{'  ^_|_^  ', 0},
				 Rune_Strip{' |(o o)  ', 0},
				 Rune_Strip{'/ |\\_/|_ ', 0},
				 Rune_Strip{'\\_/  |_/ ', 0}]
		]
		return head_frames[0]
}
