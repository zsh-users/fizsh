#!/usr/bin/env sh
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
# modify-etc-shells.sh

_fizsh_uid=$(id -u)

_fizsh_etc_shells="/etc/shells"
_fizsh_temp_shells="/etc/shells.tmp"
_fizsh_in_etc_shells=$(cat $_fizsh_etc_shells | grep ^"$2"$)

if [ $_fizsh_uid -eq 0 ]; then # fizsh can only be manipulated by $uid 0
  if [ $1 = "--add" ]; then
    if [ "X"$_fizsh_in_etc_shells = "X" ]; then
      cp $_fizsh_etc_shells $_fizsh_temp_shells
      echo $2 >> $_fizsh_temp_shells
      mv $_fizsh_temp_shells $_fizsh_etc_shells
    fi
  fi
  if [ $1 = "--remove" ]; then
    if [ ! "X"$_fizsh_in_etc_shells = "X" ]; then
      cat $_fizsh_etc_shells | grep -v ^"$2"$ > $_fizsh_temp_shells
      mv $_fizsh_temp_shells $_fizsh_etc_shells
    fi
  fi
fi
