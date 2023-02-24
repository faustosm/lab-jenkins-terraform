pipeline{
    agent any
    environment {
                LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins_terraform') // instalar plugin aws credentiasl
                AWS_DEFAULT_REGION = credentials('AWS_DEFAULT_REGION') // criar uma variavel nos jenkins
                }
    tools {
        terraform 'terraform'
    }                 
        parameters{
            choice(name: 'module', choices: ['network', 'master','nodes'], description: 'Choose which module to create') // add os modulos do projeto
            booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy infrastructure instead of creating it')
        }      
        stages{
            stage('Terraform Init'){
                steps{
                    sh"terraform init"
                }
            }
            stage('Terraform Plan') {
                when {
                    expression { params.destroy == false }
                }
                steps {
                    input message: 'Are you sure you want to run terraform plan?', ok: 'Plan', submitterParameter: 'plan_confirm'
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'crendentials_aws_jenkins_terraform', //adicionar o id das credentials aws
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                    ]]) {
                        sh "terraform plan -out myplan -target=module.${params.module}"
                    }
                }
            }
            stage('Terraform Apply') {
                when {
                    expression { params.destroy == false && (currentBuild.result == null || currentBuild.result == 'SUCCESS') }
                }
                steps {
                    input message: 'Are you sure you want to run terraform apply?', ok: 'Apply', submitterParameter: 'apply_confirm'
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding', 
                        credentialsId: 'crendentials_aws_jenkins_terraform', //adicionar o id das credentials aws
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                    ]]) {
                        sh "terraform apply myplan"
                    }
                }
            }            
        }
}