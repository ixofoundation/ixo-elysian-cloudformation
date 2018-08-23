#!/bin/sh

# Supported values
SUPPORTED_ENVIRONMENTS=("prod" "uat")
SUPPORTED_REGIONS=("us-east-1" "eu-west-1")

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

if [ "$HELP" = true ] || [ "$INVALID_TARGET_ENVIRONMENT" = true ];
then
    echo "\nUsage: $0 [Options]"
    echo "\nOptions:"
    echo "\t-t, --target-environment\n\t\t(valid values: ${SUPPORTED_ENVIRONMENTS[@]})."
    echo "\t-s, --stack-suffix\n\t\t(Must contain only letters, numbers, dashes and start with an alpha character.)"
    exit
fi

case "$TARGET_ENVIRONMENT" in
  prod)
    TARGET_REGION="us-east-1"
    ;;
  uat)
    TARGET_REGION="eu-west-1"
    shift 1
    ;;
esac

aws cloudformation create-stack --stack-name Elysian-ELB-Proxy-Network-Stack$STACK_SUFFIX --template-body file://templates/ElysianProxiedNetworkStack.yaml  --parameters file://parameters/ElysianProxiedNetworkStack.parameters.json --profile trustlab.cli --region $TARGET_REGION
