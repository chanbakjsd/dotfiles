module main

import (
	math
	os
)

fn main() {
	df := os.exec('df -P /') or {
		panic('Cannot stat file system with `df`')
	}
	mut sanitized := []string
	for item in df.output.split('\n')[1].split(' ') {
		if item != '' {
			sanitized << item
		}
	}
	used_percentage := math.round(sanitized[2].f64() / sanitized[1].f64() * 100 * 100) / 100
	mut used_percent_str := used_percentage.strlong()
	if used_percent_str.len == 4 {
		used_percent_str += '0'
	}
	println('${used_percent_str}%')
	println('${used_percent_str}%')
	if used_percentage > 90 {
		println('#FF0000')
	} else if used_percentage > 80 {
		println('#FF4444')
	} else if used_percentage > 70 {
		println('#FFF600')
	}
}
