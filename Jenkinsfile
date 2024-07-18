pipeline {
    agent any
    
    parameters {
        choice(name: 'ENV', choices: ['dev', 'QA', 'prod'], description: 'Select environment to deploy to')
    }
    
    environment {
        AWS_REGION = 'us-west-2' // Set your default AWS region if necessary
    }
    
    stages {
        stage('Fetch AWS Credentials') {
            steps {
                // No need for 'withCredentials' block if using AWS Credentials Plugin
                script {
                    env.AWS_REGION = 'us-west-2' // Set AWS region as an environment variable if necessary
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    dir("${params.ENV}") { // Switch to the selected environment directory
                        checkout scm // Checkout the source code from your repository
                        withEnv([
                            "AWS_REGION=${env.AWS_REGION}"
                        ]) {
                            // Execute Terraform commands with AWS credentials from Jenkins credentials store
                            sh 'terraform init'
                            sh 'terraform apply -auto-approve'
                        }
                    }
                }
            }
        }
    }
}
