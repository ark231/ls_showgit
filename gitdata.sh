#!/bin/bash
get_git_data(){
	#tmp_arg=("$@")
	#unset tmp_arg[0]
	#tmp_arg=${tmp_arg[@]}
	tmp_arg=$2
	#tmp_pathes=($(git ls-files -m))
	tmp_pathes=( $($tmp_arg) )
	tmp_files=()
	tmp_dirs=()
	tmp_prev_a_dir=""
	for a_file in ${tmp_pathes[@]}
	do
		tmp_a_dir=$(dirname $a_file)
		if [ $tmp_a_dir = "." ];then
			tmp_files+=($(basename $a_file))
		fi
		while true
		do
			tmp_upper_dir=$(dirname $tmp_a_dir)
			if [[ "$tmp_upper_dir" != "." ]];then
				tmp_a_dir=$tmp_upper_dir
			else
				break
			fi
		done
		if [[ "$tmp_a_dir" != "$tmp_prev_a_dir" ]];then
			tmp_dirs+=($tmp_a_dir)
		fi
		tmp_prev_a_dir=$tmp_a_dir
	done

	varname_files="files_$1"
	varname_dirs="dirs_$1"
	declare -rn return_files=$varname_files
	return_files=("${tmp_files[@]}")
	declare -rn return_dirs=$varname_dirs
	return_dirs=("${tmp_dirs[@]}")
#	eval $varname_files=${tmp_files[@]}
#	eval $varname_dirs=${tmp_dirs[@]}
}
