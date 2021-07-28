#!/bin/bash
get_git_data(){
	tmp_dirs=$($2|xargs -r dirname|sed -e"s/\\/.*//"|sort|uniq|grep -v "^.\$")
	tmp_files=$($2|grep "^[^/]\+\$"|xargs -r basename -a)
	varname_files="files_$1"
	varname_dirs="dirs_$1"
	declare -rn return_files=$varname_files
	return_files=("$tmp_files")
	declare -rn return_dirs=$varname_dirs
	return_dirs=("$tmp_dirs")
}
