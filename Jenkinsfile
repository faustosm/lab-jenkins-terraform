
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
                sh ('terraform init') 
            }
        }
        stage('terraform  action') {
            steps {
                echo "terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve')
            }
        }
    }
    
}