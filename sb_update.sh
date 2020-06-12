#!/bin/bash

# Copyright (c) 2020 ProCxx team and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

DIRNAME="out-$(date +%s)"

function sb_update {
    echo "Updating $2 submodule..."
    git clone "git@github.com:kepka-app/$2.git" "$DIRNAME/$2"
    pushd "$DIRNAME/$2"
        git checkout "$3"
        git remote add upstream "https://github.com/$1/$2.git"
        git fetch upstream
        git rebase "upstream/$3"
        git push
    popd
}

function sb_start {
    sb_update desktop-app lib_qr master
    sb_update desktop-app rlottie master
    sb_update desktop-app lib_storage master
    sb_update desktop-app libdbusmenu-qt master
    sb_update desktop-app lib_updater master
    sb_update desktop-app lib_tl master
    sb_update desktop-app lib_lottie master
    sb_update desktop-app lib_spellcheck master
    sb_update desktop-app lib_crl master
    sb_update desktop-app lib_rpl master
    sb_update desktop-app codegen master
    sb_update desktop-app lib_base master
    sb_update telegramdesktop libtgvoip tdesktop
    sb_update desktop-app cmake_helpers master
    sb_update desktop-app lib_ui master
}

function sb_finalize {
    if [ -d "$DIRNAME" ]; then
        echo "Removing temporary files..."
        rm -rf "$DIRNAME"
    fi
    echo "Successfully completed."
}

sb_start
sb_finalize
