pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
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
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        // stage('Install Terraform') {
        //     steps {
        //         withEnv(['TF_VERSION=1.0.8']) {
        //             sh 'curl -LO https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && unzip terraform_${TF_VERSION}_linux_amd64.zip && sudo mv terraform /usr/local/bin/terraform && rm terraform_${TF_VERSION}_linux_amd64.zip'
        //         }
        //     }
        // }        
        stage('Terraform Init') {
            steps {
                sh 'terraform init -backend-config="bucket=my-bucket-jenkins-terraform"'
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
                    }
                }
            }
        }
    }
}
