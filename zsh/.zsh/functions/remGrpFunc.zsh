#!/bin/zsh

debug=false

function remGrpFunc() {
    local fInString=$1
    if $debug; then
        echo "remGrpFunc received: $fInString" >&2
    fi
    
    if grep -q "\[.*\]" <<< "$fInString"; then  
        local test=$(echo "$fInString")
        local lTemp=${test%%\[*}
        lTemp+=${test#*\]}
    else
        local test=$(echo "$fInString")
        local lTemp=${test%%\(*}
        lTemp+=${test#*\)}  

    fi
    
    #delta1
    local result=$(echo "$lTemp" | xargs)
    
    if $debug; then
        echo "remGrpFunc returning: $result" >&2
    fi
    echo "$result"
}

function mainRemGrpFunc() {
    local inputString=$1
    local temp=$inputString
    local curCount=0
    if $debug; then
        echo "Initial temp: $temp" >&2
    fi
    #temp dbl quotes to handle spaces
    curCount=$(echo "$temp" | grep -Eo "\[|\(" | wc -w | xargs)
    if $debug; then
        echo "curCount: $curCount" >&2
    fi
    
    for (( i=1; i<=curCount; i++ )); do
        if $debug; then
            echo "Iteration: $i" >&2
        fi
        temp=$(remGrpFunc "$temp")
        if $debug; then
            echo "Updated temp: $temp" >&2
        fi
    done
    if $debug; then
        echo "Final temp: $temp" >&2
    fi
    echo "$temp"
}

# testVal="strt[SakuraCircle] Ore ga Kanojo o Okasu Wake - 05 (DVD 720x480 h264 AAC) [7EFE720C].mkv"

# mainRemGrpFunc "$testVal"
