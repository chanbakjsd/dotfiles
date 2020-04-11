module main

import (
	os
)

fn main() {
	mut flag := ''
	match os.args[1] {
		'window' {
			flag = '-ub'
		}
		'selection' {
			flag = '-sf'
		}
		'global' {}
		else {
			exit(0)
		}
	}
	pcnt := '%'
	mut a := os.exec("scrot $flag 'Screenshot from ${pcnt}Y-${pcnt}m-${pcnt}d ${pcnt}H-${pcnt}M-${pcnt}S.png' -e 'echo \$f'") or {
		exit(0)
	}
	file := a.output.trim_space()
	os.exec('mv "$file" "/tmp/$file"') or {
		panic('Move failed')
	}
	go copy_to_clipboard(file)
	mut message := ''
	match os.args[1] {
		'window' {
			message = 'A screenshot of the current window has been taken. ($file)'
		}
		'selection' {
			message = 'A screenshot of the selection has been taken. ($file)'
		}
		'global' {
			message = 'A global screenshot has been taken. ($file)'
		}
		else {}
	}
	os.exec('notify-send -a Scrot Scrot "$message"') or {}
}

fn copy_to_clipboard(file string) {
	os.exec('xclip -selection clipboard -t image/png -i < "/tmp/$file"') or {
		panic('xclip failed')
	}
}
