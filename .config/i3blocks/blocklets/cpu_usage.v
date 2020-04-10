module main

import (
	math
	os
)

fn main() {
	if os.getenv('BLOCK_BUTTON') == '1' {
		list_cpu_hogger()
	}
	print_cpu_usage()
}

[inline]
fn print_cpu_usage() {
	file := os.exec('cat /proc/stat') or {
		println("ERROR: Can't `cat /proc/stat`")
		return
	}
	for line in file.output.split('\n') {
		split := remove_empty_string(line.split(' '))
		if split[0] != 'cpu' {
			continue
		}
		clean := []f64
		for s in split[1..] {
			clean << s.f64()
		}
		// Calculate usage
		idle := (clean[3] * 100.0) / (clean[0]+clean[1]+clean[2]+clean[3]+clean[4]+clean[5]+clean[6])
		usage := math.round((100.0 - idle) * 100) / 100
		mut used_percent_str := usage.strlong()
		if !used_percent_str.contains('.') {
			used_percent_str += '.'
		}
		for used_percent_str.len <= 4 {
			used_percent_str += '0'
		}
		used_percent_str += '%'
		println(used_percent_str)
		println(used_percent_str)
		if usage > 90 {
			println('#FF0000')
		} else if usage > 80 {
			println('#FF4444')
		} else if usage > 70 {
			println('#FFF600')
		}
	}
}

[inline]
fn list_cpu_hogger() {
	res := os.exec('ps aux') or {
		panic('cannot call `ps aux`')
	}
	mut list := []CpuUser
	for line in res.output.split('\n')[1..] {
		split := remove_empty_string(line.split(' '))
		app_path := split[10].split('/')
		parsed := CpuUser {
			name: app_path[app_path.len-1],
			usage: split[2].f64()
		}
		list << parsed
	}
	list.sort_with_compare(compare_cpu_hog)
	list = list[..5]
	mut longest_len := 0
	for s in list {
		if s.name.len > longest_len {
			longest_len = s.name.len
		}
	}
	message := ''
	for s in list {
		mut a := s.name
		for a.len < longest_len + 1 {
			a += ' '
		}
		message += '$a$s.usage.strlong()%\n'
	}
	os.exec('notify-send -u normal "CPU Hoggers" "$message"') or {
		return
	}
}

fn remove_empty_string(a []string) []string {
	mut res := []string
	for s in a {
		if s != '' {
			res << s
		}
	}
	return res
}

struct CpuUser {
	name  string
	usage f64
}

fn compare_cpu_hog(a, b &CpuUser) int {
	if a.usage < b.usage {
		return 1
	}
	if a.usage > b.usage {
		return -1
	}
	return 0
}
