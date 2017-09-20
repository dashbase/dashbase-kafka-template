#!/bin/bash

#### Helper script for ECS CLI ####

# ECS Settings
REGION="us-west-1"
KEYPAIR="dashbase-test"
INSTANCE_TYPE="r4.xlarge"
SECURITY_GROUP="sg-9ca824fa"
VPC="vpc-0c98c369"
SUBNET="subnet-e82379b1"



DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RED="\033[0;31m"
NC="\033[0m" # No Color
COMPOSE_FILE="${DIR}/../ecs-compose.yml"

# verify input param exists
function verify_cluster_name {
  if [[ -z "${2}" ]]
  then
    echo -e "${RED}Please provide a cluster name.${NC}"
    echo "EXAMPLE:"
    echo
    echo "  ${0} ${1} my-test-cluster"
    echo
    exit 1
  fi
}

# init cluster
function create {
  ecs-cli up --cluster ${1} --region ${REGION} --keypair ${KEYPAIR} \
    --capability-iam --size 1 --vpc ${VPC} --subnets ${SUBNET}  \
    --security-group ${SECURITY_GROUP} --instance-type ${INSTANCE_TYPE}
}

# delete cluster
function delete {
  ecs-cli down --cluster ${1} --region ${REGION}
}

# start Dashbase from compose
function start {
  ecs-cli compose -f $COMPOSE_FILE up -c ${1} -r ${REGION}
}

# stop Dashbase
function stop {
  ecs-cli compose -f ${COMPOSE_FILE} down -c ${1} -r ${REGION}
}


case "${1}" in
  create)
    verify_cluster_name ${1} ${2}
    create ${2}
    ;;
  start)
    verify_cluster_name ${1} ${2}
    start ${2}
    ;;
  stop)
    verify_cluster_name ${1} ${2}
    stop ${2}
    ;;
  delete)
    verify_cluster_name ${1} ${2}
    delete ${2}
    ;;
  *)
    echo "USAGE:"
    echo
    echo "  ${0} {create|start|stop|delete} <name>"
    echo
    exit 1
    ;;
esac
