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
                choices:['plan --auto-approve','apply --auto-approve','destroy --auto-approve'],
                name:'Ação',
                description: 'Descrição da Ação')

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
            stage('Ação'){
                stages{
                    stage('Networking'){
                        when {
                        expression{params.Networking == true
                        }
                }
                steps{
                    
                    sh"terraform ${params.Ação} -target=module.Netwoking"
                    
                    }
                }
                stage('Compute'){
                        when {
                        expression{params.Compute == true
                        }
                }
                steps{
                    
                    sh"terraform ${params.Ação} -target=module.Compute"
                    
                    }
                }
                stage('Notification'){
                        when {
                        expression{params.Notification == true
                        }
                }
                steps{
                    
                    sh"terraform ${params.Ação} -target=module.Notification"
                    
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