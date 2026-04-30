pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'prod'], description: 'Select environment')
    }

    environment {
        AWS_DEFAULT_REGION = "ap-southeast-2"
        AWS_CREDS = credentials('aws-jenkins-creds')
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/ronnie-cunanan/terraform-create-resources.git'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    echo "🔧 Running Terraform Init... Environment: ${params.ENVIRONMENT}"
                    echo "--------------------------------"
                    def backendKey = "envs/${params.ENVIRONMENT}/terraform.tfstate"

                    sh """
                        terraform init -input=false \
                            -backend-config="region=ap-southeast-2" \
                            -backend-config="key=${backendKey}"
                    """
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    echo "🔍 Running Terraform Plan..."
                    echo "--------------------------------"
                    sh "terraform plan -out=tfplan"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    echo "🚀 Running Terraform Apply..."
                    echo "--------------------------------"
                    sh "terraform apply -auto-approve tfplan"
                }
            }
        }
    }

    post {
        always {
            echo "🧹 Cleaning workspace..."
            cleanWs()        
        }
    }
}