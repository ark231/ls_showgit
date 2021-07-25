#!/bin/bash
dir_script=$(cd $(dirname $0);pwd)
source $dir_script/gitdata.sh
source $dir_script/output.sh
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
show_infos files_modified "modified" "black" "cyan" $data_filename
cat $data_filename
rm $data_filename
