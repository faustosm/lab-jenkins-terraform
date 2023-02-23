pipeline {
    agent any

    environment {
        LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins_terraform')
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION = 'us-east-1'
    }
    tools {
        terraform 'terraform'
    } 
    parameters {
        choice(name: 'MODULE', choices: ['networking', 'compute'], description: 'Choose the module to deploy')
        booleanParam(name: 'CONFIRM_APPLY', defaultValue: false, description: 'Confirm apply action')
        booleanParam(name: 'CONFIRM_DESTROY', defaultValue: false, description: 'Confirm destroy action')
    }

    stages {

        stage('Terraform Init') {
            steps {
                sh 'terraform init -backend-config="bucket=my-bucket-name" -backend-config="key=my-key"'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.MODULE == 'networking' || params.MODULE == 'compute' }
            }
            steps {
                script {
                    def module = params.MODULE
                    def confirm_apply = params.CONFIRM_APPLY

                    sh "terraform plan -var-file=modules/${module}/variables.tfvars -out=${module}-plan"
                    
                    if (confirm_apply) {
                        input message: "Do you want to apply the ${module} module?", ok: 'Apply'
                        sh "terraform apply ${module}-plan"
                    } else {
                        sh "echo 'Skipping apply...'"
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.MODULE == 'networking' || params.MODULE == 'compute' }
            }
            steps {
                script {
                    def module = params.MODULE
                    def confirm_destroy = params.CONFIRM_DESTROY

                    sh "terraform plan -var-file=modules/${module}/variables.tfvars -destroy -out=${module}-destroy-plan"

                    if (confirm_destroy) {
                        input message: "Do you want to destroy the ${module} module?", ok: 'Destroy'
                        sh "terraform apply ${module}-destroy-plan"
                    } else {
                        sh "echo 'Skipping destroy...'"
                    }
                }
            }
        }
    }
}
