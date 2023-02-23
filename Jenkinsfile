pipeline {
    agent any
    
    environment {
        LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins_terraform')
        AWS_DEFAULT_REGION = credentials('AWS_DEFAULT_REGION')
        
        //AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        //AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    
    tools {
        terraform 'terraform'
    }
    
    parameters {
        choice(name: 'module', choices: ['compute', 'networking'], description: 'Choose which module to create')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy infrastructure instead of creating it')
    }
    
    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Terraform Plan') {
            when {
                expression { params.destroy == false }
            }
            steps {
                input message: 'Are you sure you want to run terraform plan?', ok: 'Plan', submitterParameter: 'plan_confirm'
                withCredentials([[
                    //credentialsId: 'aws-creds',
                    LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins_terraform')
                    //accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    //secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
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
                    //credentialsId: 'aws-creds',
                    LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins_terraform')
                    //accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    //secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
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
                    credentialsId: 'aws-creds',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                ]]) {
                    sh "terraform destroy -auto-approve -target=module.${params.module}"
                }
            }
        }
    }
}
