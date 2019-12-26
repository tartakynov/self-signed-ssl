safeExit() {
  trap - INT TERM EXIT
  exit
}

# Test output path is valid
testPath() {
  if [ ! -d $OUTPATH ]; then
    echo "The specified directory \"${OUTPATH}\" does not exist"
    exit 1
  fi
}

# Santizie CN for file name
sanitize() {
  FILENAME=$(echo "${CN}" | sed -e 's/[^A-Za-z0-9._-]/_/g' | awk '{print tolower($0)}' )
}
