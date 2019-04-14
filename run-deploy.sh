#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/pretty-print.sh
cd ${DIR}

# Define help message
function show_help {
    echo """
Usage: run-deploy.sh COMMAND

    Commands

    plan_dev     : Plan terraform deploy for development environment
    plan_prod    : Plan terraform deploy for production environment
    apply_dev    : Apply terraform deploy for development environment
    apply_prod   : Apply terraform deploy for production environment
    destroy_dev  : Destroy terraform deploy for development environment
    destroy_prod : Destroy terraform deploy for production environment
    help         : Show this message
"""
}

# Print current terraform version
function version {
    print_info "Printing terraform version"
    terraform version
}

# Check for terraform formatting errors
function format {
    print_info "Check terraform config files for canonical format"
    if [[ $(terraform fmt -write=false) ]] ; then
        print_error "Terraform canonical format errors, please fix them first"
        terraform fmt -write=false -diff
        exit 1
    fi
}

# Initialise terraform
function init {
    export env=$1
    print_info "Downloads and installs modules needed for the configuration (${env})"
    terraform get -update=true
    terraform init

    print_info "Switch to the correct workspace (${env})"
    if terraform workspace list | grep ${env} &>/dev/null ; then
        terraform workspace select ${env}
    else
        terraform workspace new ${env}
    fi
}

# Plan terraform deployment
function plan {
    export env=$1
    init ${env}
    print_info "Going to plan the deployment to ${env} environment"
    terraform plan -var-file=config/${env}.tfvars
    print_info "Plan deployment to ${env} environment finished"
}

# Apply terraform deployment
function apply {
    export env=$1
    init ${env}
    print_info "Going to apply the deployment to ${env} environment"
    terraform plan -var-file=config/${env}.tfvars
    terraform apply -var-file=config/${env}.tfvars -input=false -auto-approve
    print_info "Apply deployment to ${env} environment finished"

    prepare-kubectl ${env}
}

# Destroy terraform deployment
function destroy {
    export env=$1
    init ${env}
    print_info "Going to destroy the deployment to ${env} environment"
    terraform plan -var-file=config/${env}.tfvars -destroy
    terraform destroy -var-file=config/${env}.tfvars -input=false
    print_info "Destroying deployment to ${env} environment finished"
}

function prepare-kubectl {
    export env=$1
    print_info "Preparing kubectl to use ${env} cluster"
    echo "$(terraform output kube_config)" > ./azurek8s-${env}
    print_info "Execute the following export:
        export KUBECONFIG=./azurek8s-${env}"
}

version
format

# Run
case "$1" in
    plan_dev)  plan dev ;;
    plan_prod) plan prod ;;
    apply_dev)  apply dev ;;
    apply_prod) apply prod ;;
    destroy_dev)  destroy dev ;;
    destroy_prod) destroy prod ;;
    *) show_help ; exit 1 ;;
esac

cd - 1> /dev/null
