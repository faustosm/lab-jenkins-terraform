pipeline {
    agent any
    environment {
        LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins')
    }
    stages {
        stage('Stage 1') {
            steps {
              echo 'Stage 1'
            }
        }
        stage('Stage 2'){
          steps{
            echo 'Stage 2'
          }
        }
  }
}