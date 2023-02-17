
    pipeline {
    agent any
    environment {
        LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins_terraform')
    }
    tools {
        terraform 'terraform'
}    
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/faustosm/lab-jenkins-terraform.git']]])
            }
        }
        stage('Terraform Init') {
            steps {
                sh ('terraform init') 
            }
        }
        stage('Terraform  Action') {
            steps {
                echo "terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve')
            }
        }
    }
    
}