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
        choice(name: 'module', choices: ['compute', 'networking'], description: 'Choose which module to create')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy infrastructure instead of creating it')
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
                expression { params.destroy == false }
            }
            steps {
                input message: 'Are you sure you want to run terraform plan?', ok: 'Plan', submitterParameter: 'plan_confirm'
                withCredentials([[
                    $class:'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'crendentials_aws_jenkins_terraform',
                    AWS_ACCESS_KEY_ID: 'AWS_ACCESS_KEY_ID',
                    AWS_ACCESS_KEY_ID: 'AWS_SECRET_ACCESS_KEY',
                ]]) {
                    sh "terraform plan -target=module.${params.module}"
                }
            }
        }
        
        stage('Terraform Apply') {
            when {
                expression { params.destroy == false && (currentBuild.result == null || currentBuild.result == 'SUCCESS') }
            }
            steps {
                input message: 'Are you sure you want to run terraform apply?', ok: 'Apply', submitterParameter: 'apply_confirm'
                withCredentials([[
                    $class:'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'crendentials_aws_jenkins_terraform',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                ]]) {
                    sh "terraform apply -auto-approve -target=module.${params.module}"
                }
            }
        }
        
        stage('Terraform Destroy') {
            when {
                expression { params.destroy == true && (currentBuild.result == null || currentBuild.result == 'SUCCESS') }
            }
            steps {
                input message: 'Are you sure you want to run terraform destroy?', ok: 'Destroy', submitterParameter: 'destroy_confirm'
                withCredentials([[
                    $class:'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'crendentials_aws_jenkins_terraform',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                ]]) {
                    sh "terraform destroy -auto-approve -target=module.${params.module}"
                }
            }
        }
    }
}
