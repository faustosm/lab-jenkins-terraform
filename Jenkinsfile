 
 
   pipeline {
    agent any
 
    stages {
        stage('checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/faustosm/lab-jenkins-terraform.git']]])
            }
        }
        stage('init') {
            steps {
                sh ('Terraform Init') 
            }
        }
        stage('Terraform  Action') {
            steps {
                echo "Terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve')
            }
        }
    }
    
}