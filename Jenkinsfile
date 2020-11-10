pipeline {
    agent any

    parameters {
        string(name: 'REGION', defaultValue: 'us-east-1', description: 'Input the AWS Region for EC2 instance')
        string(name: 'AMIID', defaultValue: 'imageid', description: 'Input the AMI id for EC2 instance')
        string(name: 'INSTANCETYPE', defaultValue: 'INSTANCETYPE', description: 'Specify the Instance Type')
        string(name: 'CNT', defaultValue: 'Count', description: 'Specify the Count of Instances')
        string(name: 'SUBNETID', defaultValue: 'SUBNETID', description: 'Specify the Subnet id')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Enable if action is to destroy resources')
    }
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_IN_AUTOMATION      = '1'
    }

    stages {
        
        stage('INITIALIZE') {
            steps {
                 sh 'sed -i "s/REGION/${REGION}/g" variables.tf'
                 sh 'sed -i "s/IMGID/${AMIID}/g" variables.tf'
                 sh 'sed -i "s/INSTANCETYPE/${INSTANCETYPE}/g" variables.tf'
                 sh 'sed -i "s/CNT/${CNT}/g" variables.tf'
                sh 'sed -i "s/SUBNETID/${SUBNETID}/g" variables.tf'
                                
            }
        }
        
        stage('PLAN') {
            steps {
                 sh 'terraform init -no-color -input=false'
                 sh 'terraform plan -no-color -input=false -out tfplan'
                 sh 'terraform show -no-color tfplan > tfplan.txt'
                
            }
        }
        
        stage('APPROVAL') {
            when {
              expression { params.autoApprove == false }
            }

            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }
        
        
        stage('APPLY') {
            when {
              expression { params.destroy == false }
            }
            steps {
                sh "terraform apply -no-color -input=false tfplan"
            }
        }
        
        stage('DESTROY') {
            when {
              expression { params.destroy == true }
            }
            steps {
                sh "terraform destroy -no-color -auto-approve"
            }
        }
  
    }
}
