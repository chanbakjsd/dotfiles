module main

import (
	clipboard
	os
)

const (
	down_message = ''
)

fn main() {
	routes_result := os.exec('ip route') or {
		panic('Unknown route')
	}
	default_device := routes_result.output.split('\n')[0].split(' ')[4]

	if os.getenv('BLOCK_BUTTON') == '1' {
		mut cb := clipboard.new()
		cb.copy(get_raw_ip_address(default_device))
	}

	state := os.read_file('/sys/class/net/$default_device/operstate') or {
		panic('Cannot get state for $default_device')
	}
	if state == 'down' {
		println(down_message) // Full text
		println(down_message) // Short text
		println('FF0000')
	}

	println(get_ip_address(default_device))
}

fn get_raw_ip_address(default_device string) string {
	ipaddr := os.exec('ip addr show $default_device') or {
		panic('Cannot get IP from device $default_device')
	}
	mut ipv4_address := ''
	for _line in ipaddr.output.split('\n') {
		line := _line.trim_space()
		if !line.starts_with('inet') {
			continue
		}
		if !line.contains('scope global') {
			continue
		}
		address := line.split(' ')[1]
		if line.starts_with('inet6') {
			return address
		}
		if ipv4_address == '' {
			ipv4_address = address
		}
	}
	return ipv4_address
}

fn get_ip_address(default_device string) string {
	ip := get_raw_ip_address(default_device)
	if ip.contains(':') {
		split := ip.split(':')
		censor_one := '${split[split.len-2][..2]}xx'
		censor_two := 'xx${split[split.len-1][2..]}'
		return '${split[0]}:${split[1]}:[censored]:$censor_one:$censor_two'
	}
	split := ip.split('.')
	return '${split[0]}.${split[1]}.xxx.xxx'
}
