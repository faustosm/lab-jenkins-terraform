pipeline {
    agent any
    environment {
        LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins')
    }
    stages {
        stage('Example') {
            steps {
              echo 'Hello world'
            }
        }
    }
}