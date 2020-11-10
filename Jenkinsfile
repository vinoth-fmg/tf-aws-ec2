pipeline {
    agent any

    parameters {
        string(name: 'imageid', defaultValue: 'imageid', description: 'Input the AMI id for EC2 instance')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Enable if action is to destroy resources')
    }
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_IN_AUTOMATION      = '1'
    }

    stages {
        
        stage('PLAN') {
            steps {
                 sh 'sed -i "s/IMGID/${imageid}/g" ec2.tf'
                 sh 'terraform init -no-color -input=false'
                 sh 'terraform plan -no-color -input=false -out tfplan'
                 sh 'terraform show -no-color tfplan > tfplan.txt'
                
            }
        }
   }
}
