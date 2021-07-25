#!/bin/bash
declare -Ar COLORS_CHAR=(
["default"]=""
["black"]="\x1b[30m"
["red"]="\x1b[31m"
["green"]="\x1b[32m"
["yellow"]="\x1b[33m"
["blue"]="\x1b[34m"
["magenta"]="\x1b[35m"
["cyan"]="\x1b[36m"
["white"]="\x1b[37m"
)
declare -Ar COLORS_BACK=(
["default"]=""
["black"]="\x1b[40m"
["red"]="\x1b[41m"
["green"]="\x1b[42m"
["yellow"]="\x1b[43m"
["blue"]="\x1b[44m"
["magenta"]="\x1b[45m"
["cyan"]="\x1b[46m"
["white"]="\x1b[47m"
)
COLOR_CLEAR="\x1b[00m"
__show_info(){
	# topic_filename info char_color background_color tmpfilename 
	sed -ie "s/.*$1.*/& ${COLORS_CHAR[$3]}${COLORS_BACK[$4]}$2$COLOR_CLEAR/" $5
}

show_infos(){
	declare -n info_files=$1
	for a_file in ${info_files[@]}
	do
		__show_info $a_file $2 $3 $4 $5
	done
}
