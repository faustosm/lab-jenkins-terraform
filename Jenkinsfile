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
        parameters{
            choice(
                choices:['plan','apply --auto-approve','destroy'],
                name:'Actions',
                description: 'Describes the Actions')
            booleanParam(
                defaultValue: false,
                description: 'network',
                name: 'Networking'
                )
            booleanParam(
                defaultValue: false,
                description: 'compute',
                name: 'Compute')
            booleanParam(
                defaultValue: false,
                description: 'Notify',
                name: 'Notification')
        choice(name: 'module',
        choices: ['compute', 'networking'],
        description: 'Escolha qual módulo criar')
        booleanParam(name: 'destroy',
        defaultValue: false,
        description: 'Destrua a infraestrutura em vez de criá-la')

        }      
        
        stages{
            stage('Terraform Init'){
                steps{
                    sh"terraform init"
                }
            }
        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }            
            stage('Action'){
                stages{
                    stage('Networking'){
                        when {
                        expression{params.Networking == true
                        }
                }
                steps{
                    
                    sh"terraform ${params.Actions} -target=module.Netwoking"
                    
                    }
                }
                stage('Compute'){
                        when {
                        expression{params.Compute == true
                        }
                }
                steps{
                    
                    sh"terraform ${params.Actions} -target=module.Compute"
                    
                    }
                }
                stage('Notification'){
                        when {
                        expression{params.Notification == true
                        }
                }
                steps{
                    
                    sh"terraform ${params.Actions} -target=module.Notification"
                    
                    }
                    }              
                }
            }
            stage('Terraform Completed'){
                steps{
                    echo "Terraform Done..!"
                    
            }
        }
    }
}
