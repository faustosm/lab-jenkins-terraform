pipeline {
    agent any
    environment {
        LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins')
    }
    stages {
        stage('Terraform init') {
            steps {
              echo 'aws ls s3'
            }
        }
  }
}