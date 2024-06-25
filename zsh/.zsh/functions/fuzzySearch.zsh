#!/bin/zsh

source $HOME/.zsh/functions/remGrpFunc.zsh

debug=false

# Function to perform fuzzy search
fuzzy_search() {
  local search_terms="$1"
  local search_dir="$2"
  local cleaned_terms=$(mainRemGrpFunc "$search_terms")
  if $debug; then
    echo "cleaned_terms: $cleaned_terms" >&2
  fi
  # Split the search terms into an array
  local keywords=("${(@s/ /)cleaned_terms}")
  if $debug ; then
    echo "keywords: $keywords" >&2
  fi
  local keyword_count=${#keywords[@]}
  if $debug ; then
    echo "keyword_count: $keyword_count" >&2
  fi
  local match_count=0
  local best_count=0
  local best_file=""
    local threshold=$(( keyword_count * 0.8 ))
  # Use find to list all files and grep to filter filenames containing all keywords
  find "$search_dir" -type f | while read -r file; do
    local match=true
    local file_match_count=0
    for keyword in "${keywords[@]}"; do
      if ! echo "$file" | grep -q "$keyword"; then
        match=false
        #break
      else 
        file_match_count=$((file_match_count + 1))
      fi
    done
    
    if [[ $file_match_count -ge $threshold ]]; then
      if [[ $file_match_count -gt $best_count ]]; then
        best_count=$file_match_count
        best_file="$file"
        if $debug; then 
          echo "best_file: $best_file" >&2
        fi
      fi
    fi
    match_count=$((match_count + file_match_count))
  done
  echo "$best_file"
  if $debug; then
    echo "match_count: $match_count" >&2
  fi
}

# Example usage
#partial_file_name="Ore ga Kanojo o Okasu Wake - 05 .mkv"
#search_directory="."

#fuzzy_search "$partial_file_name" "$search_directory"
