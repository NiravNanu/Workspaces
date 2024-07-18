pipeline {
    agent any
    parameters {
        choice(name: 'ENV', choices: ['dev', 'QA', 'prod'], description: 'Select environment to deploy to')
    }
    environment {
        AWS_REGION = 'us-west-2' // Update with your AWS region if necessary
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
                    // Credentials are now available as environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
                    script {
                        env.AWS_REGION = 'us-west-2' // Set AWS region as an environment variable
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    dir("${params.ENV}") {
                        checkout scm
                        withEnv(["AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID}", "AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY}", "AWS_REGION=${env.AWS_REGION}"]) {
                            sh 'terraform init'
                            sh 'terraform apply -auto-approve'
                        }
                    }
                }
            }
        }
    }
}

