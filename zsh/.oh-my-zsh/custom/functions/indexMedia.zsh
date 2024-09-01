#!/opt/homebrew/bin/zsh

MEDIA_EXTENSIONS=(m4v mp4 avi mkv wmv)
INPUT_FILE=~/Dev/fileindex.txt
extractMediaFiles() {
  fd -L -S +30m -a -H -tf -e mkv -e wmv -e mp4 -e m4v -e avi -E '*.git*' -E '*node_modules*' '/' 2> /dev/null | tee $INPUT_FILE
}

traperr() {
  echo "ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]}"
}

# set -o errtrace
# trap traperr ERR

# Wrapper function to run a command and log errors with context

organizeData() {
  count=0


runErrFunc='run_with_error_logging() {
    local input="$1"
    shift
    "$@" 2> >(while read -r line; do echo "Error processing $input: $line " >&2; done)
}'
# echo "runErrFunc: $runErrFunc"
eval "$runErrFunc"

# run_with_error_logging 'echo' 'echo' 'Hello, World!'
# echo nofile.txt | xargs -I {} zsh -c "eval $runErrFunc ; run_with_error_logging {} cat {} "

# exit 0

# export -f run_with_error_logging

  while IFS= read -r line; do
    count=$((count+1))
    # echo item $count: $line
    filename="$(basename $line)"
    extension="${filename##*.}"
    dirPath=$(dirname $line | sed 's/,/;/g')
    pathArray=(${(s:/:)dirPath})
    set -A paths 
    acc=""
    for p in $pathArray; do
      acc="$acc/$p"
      paths+=("$acc")
    done

    printf '%b,' $paths
    # printf '\n'

    # print -l "${(F)paths}" | xargs -I {} zsh -c "eval $runErrFunc ; run_with_error_logging {} printf '%s,' {} "      # -n1 | awk '{FS=" ";print $1}'
    # print -l "${(F)paths}" | xargs -I {} -- printf '%s,' {}
    # printf 'paths: %s\n' $paths
    # printf 'dirPath: %s\n' $dirPath
    # printf 'extension: %s\n' $extension
    # printf 'filename: %s\n' $filename
    # printf 'line: %s\n' $line
    printf '\b::%s::%s\n' "$filename" "$extension"
  

  done < $INPUT_FILE
  # done < =(sed -n '7803p' $INPUT_FILE)
}

orgData2() {
printf "" > ./delFileIndex.txt
while IFS= read -r line; do
  filename="$(basename $line)"
  dir="$(dirname $line)"
  printf '%s;%s\n' $dir $filename >> ./delFileIndex.txt
done < =(head -n2 $INPUT_FILE)
}

# printf "" > ./delFileIndex.txt
organizeData > ./delFileIndex.txt
# organizeData
# bat =(organizeData)
# orgData2
# bat ./delFileIndex.txt
bat =(head ./delFileIndex.txt)
