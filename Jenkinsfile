pipeline {
    agent any
    environment {
        LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins')
    }
    stages {
        stage('List Bucket S3') {
            steps {
              echo 'aws ls s3'
            }
        }
  }
}