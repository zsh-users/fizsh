#!/usr/bin/env zsh
# -------------------------------------------------------------------------------------------------
# Copyright (c) 2011 - 2017 Guido van Steen
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

################################################
#
# This file is not sourced (yet). So any garbage is automatically lost after this script completes.

################################################
#
#fizsh-prompt() { # turning this file into function does not work for some reason

  #title "fizsh" "%m:%55<...<%~"
  setopt sh_word_split
  _fizsh_dyn_pwd=""
  _fizsh_full_path="$(pwd)"
  _fizsh_tilda_path=${_fizsh_full_path/$HOME/\~}
  # write the home directory as a tilda
  [[ $_fizsh_tilda_path[2,-1] == "/" ]] && _fizsh_tilda_path=$_fizsh_tilda_path[2,-1]
  # otherwise the first element of split_path would be empty.
  _fizsh_forwards_in_tilda_path=${_fizsh_tilda_path//[^["\/"]/}
  # remove everything that is not a "/".
  _fizsh_number_of_elements_in_tilda_path=$(( $#_fizsh_forwards_in_tilda_path + 1 ))
  # we removed the first forward slash, so we need one more element than the number of slashes.
  _fizsh_saveIFS="$IFS"
  IFS="/"
  _fizsh_split_path=(${_fizsh_tilda_path})
  _fizsh_start_of_loop=1
  _fizsh_end_of_loop=$_fizsh_number_of_elements_in_tilda_path
  for i in {$_fizsh_start_of_loop..$_fizsh_end_of_loop}
    do
    if [[ $i == $_fizsh_end_of_loop ]]; then
      _fizsh_to_be_added=$_fizsh_split_path[i]'/'
      _fizsh_dyn_pwd=$_fizsh_dyn_pwd$_fizsh_to_be_added
    else
      _fizsh_to_be_added=$_fizsh_split_path[i]
      _fizsh_to_be_added=$_fizsh_to_be_added[1,1]'/'
      _fizsh_dyn_pwd=$_fizsh_dyn_pwd$_fizsh_to_be_added
    fi
  done
  unsetopt sh_word_split
  IFS=$_fizsh_saveIFS
  [[ ${_fizsh_full_path/$HOME/\~} != $_fizsh_full_path ]] && _fizsh_dyn_pwd=${_fizsh_dyn_pwd/\/~/~}
  # remove the slash in front of $HOME
  [[ $UID -ne 0 ]] && _fizsh_prompt="%n@%m%F{green} $_fizsh_dyn_pwd[0,-2]%F{reset}> %b%k%f"
  [[ $UID -eq 0 ]] && _fizsh_prompt="%n@%m%F{red} $_fizsh_dyn_pwd[0,-2]%F{reset}# %b%k%f"
  echo $_fizsh_prompt
#}
