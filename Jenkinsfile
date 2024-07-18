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
                    credentialsId: 'aws-credentials-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    script {
                        env.AWS_REGION = 'us-east-1' // Set AWS region as an environment variable
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    dir("${params.ENV}") {
                        checkout scm
                        withEnv(["AWS_REGION=${env.AWS_REGION}"]) {
                            withCredentials([[
                                $class: 'AmazonWebServicesCredentialsBinding',
                                credentialsId: 'aws-credentials-id',
                                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                            ]]) {
                                sh 'terraform init'
                                sh 'terraform apply -auto-approve'
                            }
                        }
                    }
                }
            }
        }
    }
}
