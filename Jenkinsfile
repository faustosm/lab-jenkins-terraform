pipeline {
    agent any
    
    parameters {
        choice(name: 'module', choices: ['compute', 'networking'], description: 'Choose which module to create')
    }
    
    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh "terraform plan -target=module.${params.module}"
            }
        }
        
        stage('Terraform Apply') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                sh "terraform apply -auto-approve -target=module.${params.module}"
            }
        }
    }
}
