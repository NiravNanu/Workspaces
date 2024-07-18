pipeline {
    agent any
    
    parameters {
        choice(name: 'ENV', choices: ['dev', 'QA', 'prod'], description: 'Select environment to deploy to')
    }
    
    environment {
        AWS_REGION = 'us-east-1' // Update with your AWS region if necessary
    }
    
    stages {
        stage('Fetch AWS Credentials') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials-id', // Reference to the AWS credentials stored in Jenkins
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    script {
                        env.AWS_REGION = 'us-east-1' // Set AWS region as an environment variable if necessary
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    dir("${params.ENV}") { // Switch to the selected environment directory
                        checkout scm // Checkout the source code from your repository
                        withEnv([
                            "AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID}",
                            "AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY}",
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
