#!/bin/sh

# Supported values
SUPPORTED_ENVIRONMENTS=("prod" "uat" "qa" "audit" "sdgfutures" "experiment")

isUnsupportedValue(){
   local value=$1
   shift
   local supportedValues=$@

   for supportedValue in $supportedValues;
   do
      if [ "$value" == "$supportedValue" ];
      then
        echo false
        return
      fi
   done
   echo true
   return
}

while (( "$#" )); do
  case "$1" in
    -h|--help)
      HELP=true
      shift 1
      ;;
    -t|--target-environment)
      TARGET_ENVIRONMENT=$2
      shift 1
      ;;
    -s|--stack-suffix)
      if [[ "$2" =~ ^-.* ]]; then STACK_SUFFIX=""; else STACK_SUFFIX="-$2"; fi
      shift 1
      ;;
    -c|--cert-arn)
      CERT_ARN=$2
      shift 1
      ;;
    -n|--node-did)
      NODE_DID=$2
      shift 1
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

INVALID_TARGET_ENVIRONMENT=$(isUnsupportedValue $TARGET_ENVIRONMENT ${SUPPORTED_ENVIRONMENTS[@]})

if [ "$HELP" = true ] || [ "$INVALID_TARGET_ENVIRONMENT" = true ] || [ -z "$CERT_ARN" ] || [ -z "$NODE_DID" ];
then
    echo "\nUsage: $0 [Options]"
    echo "\nOptions:"
    echo "\t-t, --target-environment\n\t\t(valid values: ${SUPPORTED_ENVIRONMENTS[@]})."
    echo "\t-s, --stack-suffix\n\t\t(Must contain only letters, numbers, dashes and start with an alpha character.)"
    echo "\t-c, --cert-arn\n\t\t(Must be an existing ARN/Amazon Resource Name for the certificate to use.)"
    echo "\t-n, --node-did\n\t\t(The DID of prefered validator node ixo blockchain node.)"
    exit
fi

IMAGE_TAG="master"
case "$TARGET_ENVIRONMENT" in
  prod)
    TARGET_REGION="us-east-1"
    ;;
  uat)
    TARGET_REGION="ap-northeast-1"
    ;;
  qa)
    TARGET_REGION="eu-west-2"
    IMAGE_TAG="dev"
    ;;
  audit)
    TARGET_REGION="eu-west-3"
    ;;
  sdgfutures)
    TARGET_REGION="eu-central-1"
    ;;
  experiment)
    TARGET_REGION="eu-west-1"
    TARGET_ENVIRONMENT="uat"
    ;;
esac
