#!/usr/bin/env zsh 
# -------------------------------------------------------------------------------------------------
# Copyright (c) 2011 Guido van Steen 
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted
# provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above copyright notice, this list of conditions
#    and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright notice, this list of
#    conditions and the following disclaimer in the documentation and/or other materials provided
#    with the distribution.
#  * Neither the name of the FIZSH nor the names of its contributors may be used to endorse or
#    promote products derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
# OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# -------------------------------------------------------------------------------------------------
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*- 
# vim: ft=zsh sw=2 ts=2 et 
# 
# /etc/fizsh/fizsh-prompt 

# This file is not sourced (yet). So any garbage is automatically lost after this script completes. 

RED="%{"$'\033[03;31m'"%}" 
GREEN="%{"$'\033[03;32m'"%}" 
BLACK="%{"$'\033[00m'"%}" 
[[ $UID -ne 0 ]] && promptcolor=$GREEN && user_token="> " 
[[ $UID -eq 0 ]] && promptcolor=$RED && user_token="# " 

#fizsh-prompt() { # turning this file into function does not work for some reason 

	#title "fizsh" "%m:%55<...<%~" 
	setopt shwordsplit 
	dyn_pwd="" 
	full_path="$(pwd)" 
	tilda_path=${full_path/$HOME/\~} 
	# write the home directory as a tilda 
  [[ $tilda_path[2,-1] == "/" ]] && tilda_path=$tilda_path[2,-1] 
  # otherwise the first element of split_path would be empty. 
	forwards_in_tilda_path=${tilda_path//[^["\/"]/} 
	# remove everything that is not a "/". 
	number_of_elements_in_tilda_path=$(( $#forwards_in_tilda_path + 1 )) 
	# we removed the first forward slash, so we need one more element than the number of slashes. 
	saveIFS="$IFS" 
	IFS="/" 
	split_path=(${tilda_path}) 
	start_of_loop=1 
	end_of_loop=$number_of_elements_in_tilda_path 
	for i in {$start_of_loop..$end_of_loop} 
		do 
		if [[ $i == $end_of_loop ]]; then 
			to_be_added=$split_path[i]'/' 
			dyn_pwd=$dyn_pwd$to_be_added 
		else 
			to_be_added=$split_path[i] 
			to_be_added=$to_be_added[1,1]'/' 
			dyn_pwd=$dyn_pwd$to_be_added 
		fi 
	done 
	unsetopt shwordsplit 
	IFS=$saveIFS 
	[[ ${full_path/$HOME/\~} != $full_path ]] && dyn_pwd=${dyn_pwd/\/~/~} 
  # remove the slash in front of $HOME 
	prompt="%n@%m%F${promptcolor} $dyn_pwd[0,-2]${BLACK}$user_token%b%k%f" 
	echo $prompt 
#} 

