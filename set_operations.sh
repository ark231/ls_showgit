#!/bin/bash
common_set(){
	if [ $2 != "=" ] || [ $4 != "and" ];then
		echo "wrong argument! $2"
		exit 1
	fi
	declare -n result_common=$1
	declare -n array1_common=$3
	declare -n array2_common=$5
	result_common=("$(printf "%s\n" "${array1_common[@]}" "${array2_common[@]}"|sort|uniq -d)")
}
diff_set(){
	if [ $2 != "=" ] || [ $4 != "minus" ];then
		echo "wront argument! $2"
		exit 1
	fi
	declare -n result_diff=$1
	declare -n array1_diff=$3
	declare -n array2_diff=$5
	common_set tmp_common_array "=" array1_diff "and" array2_diff 
	result_diff=("$(printf "%s\n" "${array1_diff[@]}" "${tmp_common_array[@]}"|sort|uniq -u)")
}
