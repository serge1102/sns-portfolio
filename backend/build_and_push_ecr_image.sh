set -e

REGION=$(aws configure get region)
ACCOUNTID=$(aws sts get-caller-identity --output text --query Account)
aws ecr get-login-password | docker login --username AWS \
  --password-stdin ${ACCOUNTID}.dkr.ecr.${REGION}.amazonaws.com

docker build -f ./Dockerfile -t sns-dev:latest .
docker tag sns-dev:latest \
  ${ACCOUNTID}.dkr.ecr.${REGION}.amazonaws.com/sns-dev:latest
docker push ${ACCOUNTID}.dkr.ecr.${REGION}.amazonaws.com/sns-dev:latest