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
            choice(
                choices:['plan','apply ','destroy'],
                name:'Actions',
                description: 'Describes the Actions')
            booleanParam(
                defaultValue: false,
                description: 'network',
                name: 'network'
                )
            booleanParam(
                defaultValue: false,
                description: 'master',
                name: 'master')
            booleanParam(
                defaultValue: false,
                description: 'nodes',
                name: 'nodes')
        }
        
        stages{
            stage('Terraform Init'){
                steps{
                    sh"terraform init"
                }
            }
            stage('Ação aplicada'){
                stages{
                    stage('Momulo network'){
                        when {
                        expression{params.network == true
                        }
                }
                steps{
                    
                    sh"terraform ${params.Actions} -target=module.network"
                    
                    }
                }
                stage('Momulo master'){
                        when {
                        expression{params.master == true
                        }
                }
                steps{
                    
                    sh"terraform ${params.Actions} -target=module.master"
                    
                    }
                }
                stage('Momulo nodes'){
                        when {
                        expression{params.nodes == true
                        }
                }
                steps{
                    
                    sh"terraform ${params.Actions} -target=module.nodes"
                    
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
