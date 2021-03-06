#!/bin/sh

set -e

SPM_PUBLIC_HEADERS_PATH="spm/Sources/TLIndexPathTools/include"
SPM_SOURCES_PATH="spm/Sources/TLIndexPathTools"

# Delete all symbolik links from `spm` folder
function cleanup() {
    rm -rf $SPM_PUBLIC_HEADERS_PATH/*.[hm]
    rm -rf $SPM_SOURCES_PATH/*.[hm]
}

function generate_spm_public_headers() {
    echo "Generate symbolic links for all public heders. *.h"
    echo "Generated under '${SPM_PUBLIC_HEADERS_PATH}'"

    public_headers_list=$(
        find "TLIndexPathTools" -name "*.[h]" -type f | sed "s| \([^/]\)|:\1|g"
    )

    SRC_ROOT=$(pwd)
    cd $SPM_PUBLIC_HEADERS_PATH

    for public_file in $public_headers_list; do
        file_to_link=$(echo $public_file | sed "s|:| |g")
        ln -s ../../../../$file_to_link

    done

    cd $SRC_ROOT
    echo "      Done"
    echo ""
}

function generate_spm_public_sources() {
    echo "Generate symbolic links for all public implementtions. *.m"
    echo "Generated under '${SPM_SOURCES_PATH}'"

    public_sources_list=$(
        find "TLIndexPathTools" -name "*.[m]" -type f | sed "s| \([^/]\)|:\1|g"
    )

    SRC_ROOT=$(pwd)
    cd $SPM_SOURCES_PATH

    for public_file in $public_sources_list; do
        file_to_link=$(echo $public_file | sed "s|:| |g")
        ln -s ../../../$file_to_link

    done

    cd $SRC_ROOT

    echo "      Done"
    echo ""
}

########## SPM generator pipeline #############
#1
cleanup
#2
generate_spm_public_headers
#3
generate_spm_public_sources
