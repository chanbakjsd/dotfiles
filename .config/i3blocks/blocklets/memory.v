module main

import (
	math
	os
)

fn main() {
	//TODO read_file doesn't work for some reason?
	meminfo := os.exec('cat /proc/meminfo') or {
		panic('Error reading memory information')
	}
	mut total_mem := 1
	mut free_mem := 0
	for line in meminfo.output.split('\n') {
		split := line.split(':')
		key := split[0].trim_space()
		value := split[1].trim_space()
		if key == 'MemTotal' {
			total_mem = value.split(' ')[0].int()
		}
		if key == 'MemAvailable' {
			free_mem = value.split(' ')[0].int()
		}
	}
	used_mem := total_mem - free_mem
	used_percentage := math.round(f64(used_mem) / total_mem * 100 * 100) / 100
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
