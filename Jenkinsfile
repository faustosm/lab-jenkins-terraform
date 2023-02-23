pipeline{
    agent any
    environment {
                LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins_terraform')
                AWS_DEFAULT_REGION = credentials('AWS_DEFAULT_REGION')
                //AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
                //AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
                    
                }
    tools {
        terraform 'terraform'
    }
    parameters {
        choice(name: 'module', choices: ['compute', 'networking'], description: 'Escolha qual módulo criar')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destrua a infraestrutura em vez de criá-la')
    }
    stages{

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
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
                input message: 'Tem certeza de que deseja executar o terraform plan?', ok: 'Plan', submitterParameter: 'plan_confirm'
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
    }
}