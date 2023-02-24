pipeline{
    agent any
    environment {
                LICENSE_KEY_FILE = credentials('crendentials_aws_jenkins_terraform')
                AWS_DEFAULT_REGION = credentials('AWS_DEFAULT_REGION')
                }
    tools {
        terraform 'terraform'
    }                 
        parameters{
            choice(name: 'module', choices: ['network', 'master','nodes'], description: 'Choose which module to create')
            booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy infrastructure instead of creating it')
        
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
                    credentialsId: 'crendentials_aws_jenkins_terraform',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                ]]) {
                    sh "terraform plan -target=module.${params.module}"
                }
            }
        }            

}
