#!/usr/bin/env zsh
#
# /etc/fizsh-miscellaneous.zsh
#
# -------------------------------------------------------------------------------------------------
# Copyright (c) 2011 - 2017 Guido van Steen
# All rights reserved.
#
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
# -------------------------------------------------------------------------------------------------
#
# This script takes care of binding the keys.
#

################################################
#
# Register history-substring-search-up and history-substring-search-down as user-defined zle widgets
#
zle -N history-substring-search-up
zle -N history-substring-search-down

################################################
#
# Create the array "key" if it does not exist
#
[[ $(echo ${key+1}) != "1" ]] && typeset -A key && key=(Up "${terminfo[kcuu1]}" Down "${terminfo[kcud1]}" Home "${terminfo[khome]}" End "${terminfo[kend]}" Insert "${terminfo[kich1]}" Delete "${terminfo[kdch1]}" Left "${terminfo[kcub1]}" Right "${terminfo[kcuf1]}" PageUp "${terminfo[kpp]}" PageDown "${terminfo[knp]}")

################################################
#
# Define missing keys using terminfo
#
[[ "${key[Up]}"       == "" ]]  && key[Up]="${terminfo[kcuu1]}"
[[ "${key[Down]}"     == "" ]]  && key[Down]="${terminfo[kcud1]}"
[[ "${key[Home]}"     == "" ]]  && key[Home]="${terminfo[khome]}"
[[ "${key[End]}"      == "" ]]  && key[End]}="${terminfo[kend]}"
[[ "${key[Insert]}"   == "" ]]  && key[Insert]="${terminfo[kich1]}"
[[ "${key[Delete]}"   == "" ]]  && key[Delete]="${terminfo[kdch1]}"
[[ "${key[Left]}"     == "" ]]  && key[Left]}="${terminfo[kcub1]}"
[[ "${key[Right]}"    == "" ]]  && key[Right]="${terminfo[kcuf1]}"
[[ "${key[PageUp]}"   == "" ]]  && key[PageUp]="${terminfo[kpp]}"
[[ "${key[PageDown]}" == "" ]]  && key[PageDown]="${terminfo[knp]}"

################################################
#
# Bind the keys in $key
#
bindkey  "${key[Up]}"       history-substring-search-up
bindkey  "${key[Down]}"     history-substring-search-down
bindkey  "${key[Home]}"     beginning-of-line
bindkey  "${key[End]}"      end-of-line
bindkey  "${key[Insert]}"   overwrite-mode
bindkey  "${key[Delete]}"   delete-char
bindkey  "${key[Left]}"     backward-char
bindkey  "${key[Right]}"    forward-char
bindkey  "${key[PageUp]}"   beginning-of-history
bindkey  "${key[PageDown]}" end-of-history

################################################
#
# As a fallback bind some additional key codes that could be generated
#
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey "\e[A" history-substring-search-up
bindkey "\e[B" history-substring-search-down

bindkey "^[[A" history-substring-search-up
bindkey "^[0A" history-substring-search-up

bindkey "^[[B" history-substring-search-down
bindkey "^[0B" history-substring-search-down

################################################
#
# Bind history-incremental-search-backward, history-incremental-search-forward and backward-delete-char
# history-incremental-search-backward and history-incremental-search-forward
#
bindkey "^[[1;5C" forward-word
bindkey "^[01;5C" forward-word

bindkey "^[[1;5D" backward-word
bindkey "^[01;5D" backward-word

bindkey "^?" backward-delete-char

bindkey "^r" history-incremental-search-backward
bindkey "^s" history-incremental-search-forward
