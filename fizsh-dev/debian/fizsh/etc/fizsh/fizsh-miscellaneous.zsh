#!/usr/bin/env zsh
#
# /etc/fizsh-miscellaneous.zsh
#
# -------------------------------------------------------------------------------------------------
# Copyright (c) 2011 Guido van Steen
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
# This script first binds some important keys.
#
# The script is sourced after zsh-history-substring-search.zsh.
# Therefore, it can be used to temporarily correct some glitches
# in zsh-syntax-highlighting.zsh and zsh-history-substring-search.zsh.
#
# It is also used to provide the functions "fizsh-reinstall" and
# "fizsh-upgrade"
#

################################################
#
# Bind a few important keys
#
bindkey '\e[C' forward-char
bindkey '\e[D' backward-char
bindkey '\e[3~' delete-char
bindkey '^?' backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5D' backward-word
#
bindkey '\e[5~' beginning-of-history
bindkey '\e[6~' end-of-history
#
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward


################################################
#
# Rebind tab so that it uses syntax-highlighting
#
function expand-or-complete-and-highlight() {
  zle expand-or-complete
  _zsh_highlight
}

zle -N expand-or-complete-and-highlight expand-or-complete-and-highlight

bindkey "^I" expand-or-complete-and-highlight

################################################
#
# The following hack forces syntax-highlighting to be applied after
# we execute some command and press <UP> once, immediately afterward
#
# It is related to:
# https://github.com/zsh-users/zsh-syntax-highlighting/issues/79
#
# For example:
#
# u@h ~ /cwd> function highlight-history-substring-search-up () { <ENTER>
# u@h ~ /cwd>   zle history-substring-search-up <ENTER>
# u@h ~ /cwd> } <ENTER>
# u@h ~ /cwd> bindkey | grep "\^[[[A|B]" <ENTER>
# u@h ~ /cwd> <UP>
#
# No syntax coloring is invoked...
#
# u@h ~ /cwd> function highlight-history-substring-search-up () { <ENTER>
# u@h ~ /cwd>   _zsh_highlight <ENTER>
# u@h ~ /cwd>   zle history-substring-search-up <ENTER>
# u@h ~ /cwd> } <ENTER>
# u@h ~ /cwd> bindkey | grep "\^[[[A|B]" <ENTER>
# u@h ~ /cwd> <UP>
#
# This does invoke syntax coloring...
#
function highlight-history-substring-search-up () {
  _zsh_highlight
  zle history-substring-search-up
}

zle -N highlight-history-substring-search-up

bindkey '^[[A' highlight-history-substring-search-up

################################################
#
# Define fizsh-upgrade and fizsh-reinstall
#
################################################
#
# Add the functions _fizsh-proxy-name and _fizsh-proxy-port, _fizsh-test-proxy,
# _fizsh-test-direct, _fizsh-test-internet, which will be called by _fizsh-curl.
#
function _fizsh-proxy-name() {
  local _fizsh_scheme _fizsh_empty _fizsh_server_and_port _fizsh_rest
  IFS=/ read _fizsh_scheme _fizsh_empty _fizsh_server_and_port _fizsh_rest <<<$http_proxy
  IFS=: read _fizsh_name _fizsh_port _fizsh_rest <<<$_fizsh_server_and_port
  IFS=""
  echo $_fizsh_name
}

function _fizsh-proxy-port() {
  local _fizsh_scheme _fizsh_empty _fizsh_server_and_port _fizsh_rest
  IFS=/ read _fizsh_scheme _fizsh_empty _fizsh_server_and_port _fizsh_rest <<<$http_proxy
  IFS=: read _fizsh_name _fizsh_port _fizsh_rest <<<$_fizsh_server_and_port
  IFS=""
  echo $_fizsh_port
}

function _fizsh-test-proxy() { # required arguments $1 is proxy_name, $2 is proxy_port
  _fizsh_route_ouput=$(netstat -rn | grep -v Kern | grep -v Iface)
  if [[ $_fizsh_route_ouput != "" ]]; then
    autoload -z tcp_open
    autoload -z tcp_close
    autoload -z tcp_send
    autoload -z tcp_command
    _fizsh_open_output=$(tcp_open -q $1 $2 proxy 2>&1)
    if [[ $_fizsh_open_output[-18,-1] == "connection refused" ]]; then
      _fizsh_command_output=$(tcp_command -q -s proxy "HEAD http://www.google.com/404 HTTP/1.0\nHost: google.com\nConnection: close\n\n" 2>&1)
      _fizsh_close_output=$(tcp_close -q proxy 2>&1)
    fi
  else
    false
  fi
}

function _fizsh-test-direct() {
  _fizsh_route_ouput=$(netstat -rn | grep -v Kern | grep -v Iface)
  if [[ $_fizsh_route_ouput != "" ]]; then
    autoload -z tcp_open
    autoload -z tcp_close
    autoload -z tcp_send
    autoload -z tcp_command
    _fizsh_open_output=$(tcp_open -q 74.125.157.99 80 google 2>&1)
    if [[ $_fizsh_open_output[-11,-1] == "unreachable" ]]; then
      _fizsh_command_output=$(tcp_command -q -s proxy "HEAD /404 HTTP/1.0\nHost: google.com\nConnection: close\n\n" 2>&1)
      _fizsh_close_output=$(tcp_close -q proxy 2>&1)
    fi
  else
    false
  fi
}

function _fizsh-test-internet() {
  _fizsh_proxy_name=$(_fizsh-proxy-name)
  _fizsh_proxy_port=$(_fizsh-proxy-port)
  if [[ $_fizsh_proxy_name == "" && $_fizsh_proxy_port == "" ]]; then
    _fizsh-test-direct
  elif [[ $_fizsh_proxy_name != "" && $_fizsh_proxy_port != "" ]]; then
    _fizsh-test-proxy $_fizsh_proxy_name $_fizsh_proxy_port
  else
    false
  fi
}

################################################
#
# Add a function _fizsh-raw-download, which will be used to download newer versions of fizsh
#
# This function is based on http://www.zsh.org/mla/users/2011/msg00742.html
#
# Proxy handling was added by Guido van Steen
#
# Take care:
#   * _fizsh-raw-download is extremely basic. It is supposed to work with direct static urls only!!!!
#   * It doesn't handle the https protocol
#
# Moreover it adds <eof> to the end of the file. We will later remove this byte in _fizsh-download
#
function _fizsh-raw-download() {
  local _fizsh_return_code _fizsh_scheme _fizsh_empty _fizsh_server _fizsh_resource _fizsh_headerline
  _fizsh_return_code=0
  emulate -LR zsh
  IFS=/ read _fizsh_scheme _fizsh_empty _fizsh_server _fizsh_resource <<<$1
  if [[ $3 != "" ]]; then # proxy
    case $_fizsh_scheme in
      (https:) print -u2 SSL unsupported, falling back on HTTP ;&
      (http:) zmodload zsh/net/tcp; ztcp $2 $3 && fd=$REPLY || return_code=1;;
      (*) print -u2 $_fizsh_scheme unsupported; return 1;;
    esac
    print -l -u$fd -- \
      "GET $1 HTTP/1.0"$'\015' \
      "Host: $_fizsh_server"$'\015' \
      'Connection: close'$'\015' $'\015'
    while IFS= read -u $fd -r _fizsh_headerline; do
      [[ $_fizsh_headerline == $'\015' ]] && break
    done
    while IFS= read -u $fd -r -e; do :; done
    ztcp -c $fd
  else
    case $_fizsh_scheme in
      (https:) print -u2 SSL unsupported, falling back on HTTP ;&
      (http:) zmodload zsh/net/tcp; ztcp $_fizsh_server 80 && fd=$REPLY || return_code=1;;
      (*) print -u2 $_fizsh_scheme unsupported; return 1;;
    esac
    print -l -u$fd -- \
      "GET /$_fizsh_resource HTTP/1.0"$'\015' \
      "Host: $_fizsh_server"$'\015' \
      'Connection: close'$'\015' $'\015'
    while IFS= read -u $fd -r _fizsh_headerline; do
      [[ $_fizsh_headerline == $'\015' ]] && break
    done
    while IFS= read -u $fd -r -e; do :; done
    ztcp -c $fd
  fi
  return $_fizsh_return_code
}

################################################
#
# _fizsh-curl does some error checking in front of _fizsh-raw-download.
#
function _fizsh-curl() { # required arguement: $1="url" # allowed arguments $2=["no_proxy"|"proxy"|""]
  # handle argumengts
  if [[ ${1[1,5]} == "https" ]]; then
    echo "_fizsh-curl: https protocol is not supported"
    false
  elif [[ ${1[1,4]} != "http"  ]]; then
    echo "_fizsh-curl: $1 is not a valid HTTP url"
    false
  elif [[ $2 == "" || $2 == "proxy" ]]; then
    _fizsh_proxy_name=$(_fizsh-proxy-name)
    _fizsh_proxy_port=$(_fizsh-proxy-port)
  elif [[ $2 == "no_proxy" ]]; then
    _fizsh_proxy_name=""
    _fizsh_proxy_port=""
  else # elif [[ $2 != "proxy" && $2 != "no_proxy" && $2 != "" ]]; then
    echo "_fizsh-curl: the argument \"$2\" is not supported"
    false
  fi
  # test the connections and download if possible
  if [[ $? -eq 0 ]]; then # no error yet
    if [[ $_fizsh_proxy_name != "" && $_fizsh_proxy_port != "" ]]; then # proxy
      _fizsh-test-proxy $_fizsh_proxy_name $_fizsh_proxy_port
      [[ $? -eq 0 ]] && _fizsh-raw-download $1 $_fizsh_proxy_name $_fizsh_proxy_port 2>&1
    else
      _fizsh-test-direct
      [[ $? -eq 0 ]] && _fizsh-raw-download $1 2>&1
    fi
  fi
}

################################################
#
# _fizsh-test-bangshe tests if $1 starts with a proper bangshe like "#!/usr/bin/env zsh"
#
function _fizsh-test-bangshe() {
  # if $1 is not provided exit with 1
  [[ ( -z $1 ) ]] && return 1
  _fizsh_bangshe=$(head -n 1 $1)
  IFS=" ";read env _fizsh_zsh <<<$_fizsh_bangshe
  [[ $_fizsh_zsh != "zsh" ]] && return 2
  # else zsh is the second string in the bangshe
  return 0
}

################################################
#
# _fizsh-install-highligthing copies the highlighting files to the "~/.fizsh" directory # is used in "/usr/bin/fizsh" as well
#
function _fizsh-install-highligthing() { # $1 is the directory from where the files are copied
  'cp' -f $1/$_fizsh_F_SYNTAX $_fizsh_F_DOT_DIR/$_fizsh_F_SYNTAX
  mkdir -p $_fizsh_F_DOT_DIR/$_fizsh_F_HIGHLIGHTERS_DIR/brackets
  mkdir -p $_fizsh_F_DOT_DIR/$_fizsh_F_HIGHLIGHTERS_DIR/cursor
  mkdir -p $_fizsh_F_DOT_DIR/$_fizsh_F_HIGHLIGHTERS_DIR/main
  mkdir -p $_fizsh_F_DOT_DIR/$_fizsh_F_HIGHLIGHTERS_DIR/pattern
  mkdir -p $_fizsh_F_DOT_DIR/$_fizsh_F_HIGHLIGHTERS_DIR/root
  'cp' -f $1/brackets-highlighter.zsh $_fizsh_F_DOT_DIR/$_fizsh_F_HIGHLIGHTERS_DIR/brackets/brackets-highlighter.zsh
  'cp' -f $1/cursor-highlighter.zsh $_fizsh_F_DOT_DIR/$_fizsh_F_HIGHLIGHTERS_DIR/cursor/cursor-highlighter.zsh
  'cp' -f $1/main-highlighter.zsh $_fizsh_F_DOT_DIR/$_fizsh_F_HIGHLIGHTERS_DIR/main/main-highlighter.zsh
  'cp' -f $1/pattern-highlighter.zsh $_fizsh_F_DOT_DIR/$_fizsh_F_HIGHLIGHTERS_DIR/pattern/pattern-highlighter.zsh
  'cp' -f $1/root-highlighter.zsh $_fizsh_F_DOT_DIR/$_fizsh_F_HIGHLIGHTERS_DIR/root/root-highlighter.zsh
}

################################################
#
# _fizsh-download downloads all the scripts needed by fizsh, and checks if they have a proper bangshe
# this function returns 1 if something is wrong
#
function _fizsh-download() {
  _fizsh-curl $_fizsh_F_GOOGLECODE/$_fizsh_F_SYNTAX > $1/$_fizsh_F_SYNTAX 2> /dev/null || return 1
  _fizsh-curl $_fizsh_F_GOOGLECODE/brackets-highlighter.zsh > $1/brackets-highlighter.zsh 2> /dev/null || return 1
  _fizsh-curl $_fizsh_F_GOOGLECODE/cursor-highlighter.zsh > $1/cursor-highlighter.zsh 2> /dev/null || return 1
  _fizsh-curl $_fizsh_F_GOOGLECODE/main-highlighter.zsh > $1/main-highlighter.zsh 2> /dev/null || return 1
  _fizsh-curl $_fizsh_F_GOOGLECODE/pattern-highlighter.zsh > $1/pattern-highlighter.zsh 2> /dev/null || return 1
  _fizsh-curl $_fizsh_F_GOOGLECODE/root-highlighter.zsh > $1/root-highlighter.zsh 2> /dev/null || return 1
  _fizsh-curl $_fizsh_F_GOOGLECODE/$_fizsh_F_SEARCH > $1/$_fizsh_F_SEARCH 2> /dev/null || return 1
  _fizsh-curl $_fizsh_F_GOOGLECODE/$_fizsh_F_PROMPT > $1/$_fizsh_F_PROMPT 2> /dev/null || return 1
  _fizsh-curl $_fizsh_F_GOOGLECODE/$_fizsh_F_FIZSHRC > $1/$_fizsh_F_FIZSHRC 2> /dev/null || return 1
  _fizsh-curl $_fizsh_F_GOOGLECODE/$_fizsh_F_MISC > $1/$_fizsh_F_MISC 2> /dev/null || return 1
  _fizsh-curl $_fizsh_F_GOOGLECODE/$_fizsh_F_FIZSH > $1/$_fizsh_F_FIZSH 2> /dev/null || return 1
  # here is a hack to get rid of the additional <eof> which were added by _fizsh-raw-download
  head -c -1 $1/$_fizsh_F_SYNTAX > $1/tmp 2> /dev/null; mv -f $1/tmp $1/$_fizsh_F_SYNTAX 2> /dev/null
  head -c -1 $1/brackets-highlighter.zsh > $1/tmp 2> /dev/null; mv -f $1/tmp $1/brackets-highlighter.zsh 2> /dev/null
  head -c -1 $1/cursor-highlighter.zsh > $1/tmp 2> /dev/null; mv -f $1/tmp $1/cursor-highlighter.zsh 2> /dev/null
  head -c -1 $1/main-highlighter.zsh > $1/tmp 2> /dev/null; mv -f $1/tmp $1/main-highlighter.zsh 2> /dev/null
  head -c -1 $1/pattern-highlighter.zsh > $1/tmp 2> /dev/null; mv -f $1/tmp $1/pattern-highlighter.zsh 2> /dev/null
  head -c -1 $1/root-highlighter.zsh > $1/tmp 2> /dev/null; mv -f $1/tmp $1/root-highlighter.zsh 2> /dev/null
  head -c -1 $1/$_fizsh_F_SEARCH > $1/tmp 2> /dev/null; mv -f $1/tmp $1/$_fizsh_F_SEARCH 2> /dev/null
  head -c -1 $1/$_fizsh_F_PROMPT > $1/tmp 2> /dev/null; mv -f $1/tmp $1/$_fizsh_F_PROMPT 2> /dev/null
  head -c -1 $1/$_fizsh_F_FIZSHRC > $1/tmp 2> /dev/null; mv -f $1/tmp $1/$_fizsh_F_FIZSHRC 2> /dev/null
  head -c -1 $1/$_fizsh_F_MISC > tmp 2> /dev/null; mv -f tmp $1/$_fizsh_F_MISC 2> /dev/null
  head -c -1 $1/$_fizsh_F_FIZSH > tmp 2> /dev/null; mv -f tmp $1/$_fizsh_F_FIZSH 2> /dev/null
  # test if we have proper bangshes
  _fizsh-test-bangshe $1/$_fizsh_F_SYNTAX || return 1
  _fizsh-test-bangshe $1/brackets-highlighter.zsh || return 1
  _fizsh-test-bangshe $1/cursor-highlighter.zsh || return 1
  _fizsh-test-bangshe $1/main-highlighter.zsh || return 1
  _fizsh-test-bangshe $1/pattern-highlighter.zsh || return 1
  _fizsh-test-bangshe $1/root-highlighter.zsh || return 1
  _fizsh-test-bangshe $1/$_fizsh_F_SEARCH || return 1
  _fizsh-test-bangshe $1/$_fizsh_F_PROMPT || return 1
  _fizsh-test-bangshe $1/$_fizsh_F_FIZSHRC || return 1
  _fizsh-test-bangshe $1/$_fizsh_F_MISC || return 1
  _fizsh-test-bangshe $1/$_fizsh_F_FIZSH || return 1
}

################################################
#
# _fizsh-copy-config-files copies all the downloaded scripts to the "~/.fizsh" directory
#
function _fizsh-copy-config-files() {
  echo -en "Installing config files... "
  if [[ -e $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/$_fizsh_F_SEARCH && -e $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/$_fizsh_F_SYNTAX &&
      -e $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/brackets-highlighter.zsh && -e $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/cursor-highlighter.zsh &&
      -e $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/main-highlighter.zsh && -e $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/pattern-highlighter.zsh &&
      -e $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/root-highlighter.zsh &&
      -e $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/$_fizsh_F_PROMPT && -e $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/$_fizsh_F_FIZSHRC &&
      -e $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/$_fizsh_F_FIZSH && -e $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/$_fizsh_F_MISC ]]; then
    _fizsh-install-highligthing $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR
    'cp' -f $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/$_fizsh_F_SEARCH $_fizsh_F_DOT_DIR/$_fizsh_F_SEARCH
    'cp' -f $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/$_fizsh_F_PROMPT $_fizsh_F_DOT_DIR/$_fizsh_F_PROMPT
    'cp' -f $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/$_fizsh_F_FIZSHRC $_fizsh_F_DOT_DIR/.zshrc
    'cp' -f $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/$_fizsh_F_MISC $_fizsh_F_DOT_DIR/$_fizsh_F_MISC
    'cp' -f $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR/$_fizsh_F_FIZSH $_fizsh_F_DOT_DIR/$_fizsh_F_FIZSH
     echo "yes"
  else
    echo "no"
    echo "_fizsh-copy-config-files: error:"
    echo "Some configurarion files are not available"
  fi
}

################################################
#
# _fizsh-resource-config-files resources the config files after they have been changed
#
function _fizsh-resource-config-files() {
  source $_fizsh_F_DOT_DIR/.zshrc
}

################################################
#
# the user may call fizsh-upgrade in order to upgrade fizsh
#
function fizsh-upgrade() {
  trap EXIT SIGINT # quit this function when ctrl-c is hit
  if [[ $1 != "--force" ]]; then
    print "_fizsh-upgrade: continue (y/n) "
    read fizsh_upgrade_answer
    if [[ "$fizsh_upgrade_answer" == "y" || "$fizsh_upgrade_answer" == "Y" ]]; then
      fizsh-upgrade --force
    fi
  else
    _fizsh_F_RANDOM_DIR=$RANDOM
    while [[ -d $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR ]]; do
      _fizsh_F_RANDOM_DIR=$RANDOM
    done
    mkdir -p $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR
    echo -en "Checking internet connectivity... "
    _fizsh-test-internet
    if [[ $? -ne 0 ]]; then
      echo "no"
      echo "_fizsh-upgrade: unable to connect to the internet"
    else
      echo "yes"
      echo -en "Retrieving files from the internet... "
      _fizsh-download $_fizsh_F_TMP_DIR/$_fizsh_F_RANDOM_DIR
      if [[ $? -eq 0 ]]; then
        echo "yes"
        _fizsh-copy-config-files
        _fizsh-resource-config-files
      else
        echo "no"
        echo "_fizsh-upgrade: some files were not downloaded properly"
      fi
    fi
  fi
}

################################################
#
# the user may call fizsh-reinstall in order to reinstall the original configuration files in "~/.fizsh"
#
function fizsh-reinstall() {
  trap EXIT SIGINT # quit this function when ctrl-c is hit
  if [[ $1 != "--force" ]]; then
    echo -en "fizsh-reinstall: continue (y/n) "
    read fizsh_reinstall_answer
    if [[ "$fizsh_reinstall_answer" == "y" || "$fizsh_reinstall_answer" == "Y" ]]; then
      "fizsh-reinstall" "--force"
    fi
  else
    echo -en "Reinstalling config files... "
    if [[ -e $_fizsh_F_ETC_DIR/$_fizsh_F_SEARCH && -e $_fizsh_F_ETC_DIR/$_fizsh_F_SYNTAX &&
        -e $_fizsh_F_ETC_DIR/brackets-highlighter.zsh && -e $_fizsh_F_ETC_DIR/cursor-highlighter.zsh &&
        -e $_fizsh_F_ETC_DIR/main-highlighter.zsh && -e $_fizsh_F_ETC_DIR/pattern-highlighter.zsh &&
        -e $_fizsh_F_ETC_DIR/root-highlighter.zsh &&
        -e $_fizsh_F_ETC_DIR/$_fizsh_F_MISC && -e $_fizsh_F_ETC_DIR/$_fizsh_F_FIZSHRC &&
        -e $_fizsh_F_BIN_DIR/$_fizsh_F_FIZSH ]]; then
      rm -rf $_fizsh_F_DOT_DIR/$_fizsh_F_HIGHLIGHTERS_DIR
      _fizsh-install-highligthing $_fizsh_F_ETC_DIR
      'cp' -f $_fizsh_F_ETC_DIR/$_fizsh_F_SEARCH $_fizsh_F_DOT_DIR/$_fizsh_F_SEARCH
      'cp' -f $_fizsh_F_ETC_DIR/$_fizsh_F_PROMPT $_fizsh_F_DOT_DIR/$_fizsh_F_PROMPT
      'cp' -f $_fizsh_F_ETC_DIR/$_fizsh_F_FIZSHRC $_fizsh_F_DOT_DIR/.zshrc
      'cp' -f $_fizsh_F_ETC_DIR/$_fizsh_F_MISC $_fizsh_F_DOT_DIR/$_fizsh_F_MISC
      'cp' -f $_fizsh_F_BIN_DIR/$_fizsh_F_FIZSH $_fizsh_F_DOT_DIR/$_fizsh_F_FIZSH
      _fizsh-resource-config-files
      echo "yes"
    else
      echo "no"
      echo "fizsh-reinstall: error:"
      echo "Some configurarion files are not available"
    fi
  fi
}

function _fizsh-message-after-local-upgrade () {
  echo $_fizsh_F_CENTRAL_VERSION > $_fizsh_F_DOT_DIR/$_fizsh_F_VERSION_FILE
  export _fizsh_F_LOCAL_VERSION=$_fizsh_F_CENTRAL_VERSION
  export _fizsh_F_UPGRADE_LOCAL=0
  echo -e ""
  echo -e "You are running fizsh version \033[03;32m$_fizsh_F_CENTRAL_VERSION\033[00m now."
  echo -e ""
  echo -e "You may type \033[03;32mfizsh-upgrade\033[00m to upgrade to the latest"
  echo -e "version available on the internet."
  echo -e ""
  echo -e "You may later type \033[03;32mfizsh-reinstall\033[00m to revert to"
  echo -e "version \033[03;32m$_fizsh_F_CENTRAL_VERSION\033[00m again."
  echo -e ""
}

if [[ $_fizsh_F_UPGRADE_LOCAL -eq 1 ]]; then
  _fizsh-message-after-local-upgrade
fi
