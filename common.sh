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

# Prompt for variables that were not provided in arguments
checkVariables() {
  # Country
  if [ -z "$C" ]; then
    echo -n "Country Name (2 letter code) [AU]: "
    read -r C
  fi

  # State
  if [ -z "$ST" ]; then
    echo -n "State or Province Name (full name) [Some-State]: "
    read -r ST
  fi

  # Locality
  if [ -z "$L" ]; then
    echo -n "Locality Name (eg, city) []: "
    read -r L
  fi

  # Organization
  if [ -z "$O" ]; then
    echo -n "Organization Name (eg, company) [Internet Widgits Pty Ltd]: "
    read -r O
  fi

  # Organizational Unit
  if [ -z "$OU" ]; then
    echo -n "Organizational Unit Name (eg, section) []: "
    read -r OU
  fi

  # Common Name
  if [ -z "$CN" ]; then
    echo -n "Common Name (e.g. server FQDN or YOUR name) []: "
    read -r CN
  fi

  # Email Address
  if [ -z "$emailAddress" ]; then
    echo -n "Email Address []: "
    read -r emailAddress
  fi
}

# Show variable values
showVals() {
  echo "Country: ${C}";
  echo "State: ${ST}";
  echo "Locality: ${L}";
  echo "Organization: ${O}";
  echo "Organization Unit: ${OU}";
  echo "Common Name: ${CN}";
  echo "Email: ${emailAddress}";
  echo "Output Path: ${OUTPATH}";
  echo "Certificate Duration (Days): ${DURATION}";
  echo "Verbose: ${VERBOSE}";
}

# Process Arguments
while [ "$1" != "" ]; do
  PARAM=$(echo "$1" | awk -F= '{print $1}')
  VALUE=$(echo "$1" | awk -F= '{print $2}')
  case $PARAM in
    -h|--help) help; safeExit ;;
    -c|--country) C=$VALUE ;;
    -s|--state) ST=$VALUE ;;
    -l|--locality) L=$VALUE ;;
    -o|--organization) O=$VALUE ;;
    -u|--unit) OU=$VALUE ;;
    -n|--common-name) CN=$VALUE ;;
    -e|--email) emailAddress=$VALUE ;;
    -p|--path) OUTPATH=$VALUE; testPath ;;
    -d|--duration) DURATION=$VALUE ;;
    -v|--verbose) VERBOSE=1 ;;
    *) echo "ERROR: unknown parameter \"$PARAM\""; help; exit 1 ;;
  esac
  shift
done
