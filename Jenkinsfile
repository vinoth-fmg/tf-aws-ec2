pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'dev', description: 'Environment to use for deployment')
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
                 sh 'terraform init -no-color -input=false'
                 sh 'terraform plan -no-color -input=false -out tfplan'
                 sh 'terraform show -no-color tfplan > tfplan.txt'
                
            }
        }
   }
}
