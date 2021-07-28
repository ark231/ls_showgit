#!/bin/bash
dir_script=$(cd $(dirname $0);pwd)
source $dir_script/gitdata.sh
source $dir_script/output.sh
source $dir_script/set_operations.sh
which git >/dev/null
git_exists=$?
git status 1>/dev/null 2>/dev/null
is_git_repo=$?
if [ "${git_exists}" != 0 ] || [ "${is_git_repo}" != 0 ];then
	ls --color=always $@
	exit $?
fi
data_filename=$(mktemp)
ls --color=always $@ >$data_filename
get_git_data "modified" "git ls-files -m"
get_git_data "deleted" "git ls-files -d"
get_git_data "nontraced" "git ls-files -o "
get_git_data "not_yet_traced" "git ls-files -o --exclude-standard"
diff_set files_ignored "=" files_nontraced "minus" files_not_yet_traced
#diff_set dirs_ignored "=" dirs_nontraced "minus" dirs_not_yet_traced
dirs_ignored=("$(git ls-files -o --directory|grep "^[^/]\+/\$"|sed -e's/\///')")
echo ${dirs_ignored[@]}
show_infos files_modified "modified" "black" "cyan" $data_filename
show_infos dirs_modified "contains_modified" "black" "magenta" $data_filename
show_infos files_not_yet_traced "not_yet_traced" "black" "red" $data_filename
show_infos dirs_not_yet_traced "contains_not_yet_traced" "white" "red" $data_filename
show_infos files_ignored "ignored" "black" "green" $data_filename
show_infos dirs_ignored "ignored" "black" "green" $data_filename
cat $data_filename
rm $data_filename
