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
        stage('Terraform Apply') {
            when {
                expression { params.destroy == false && (currentBuild.result == null || currentBuild.result == 'SUCCESS') }
            }
            steps {
                input message: 'Are you sure you want to run terraform apply?', ok: 'Apply', submitterParameter: 'apply_confirm'
                withCredentials([[
                    $class:'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'crendentials_aws_jenkins_terraform',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                ]]) {
                    sh "terraform apply -auto-approve -target=module.${params.module}"
                }
            }
        }        
    }
}