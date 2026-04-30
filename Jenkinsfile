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

        stage('Select Environment') {
            steps {
                script {
                    echo "🌍 Selected environment: ${ENVIRONMENT}"

                    // Build path to tfvars file
                    env.TFVARS_FILE = "env/${ENVIRONMENT}.tfvars"

                    // Validate file exists
                    if (!fileExists(env.TFVARS_FILE)) {
                        error "❌ Missing ${env.TFVARS_FILE} — cannot continue"
                    }

                    echo "📄 Using tfvars file: ${env.TFVARS_FILE}"
                }
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
                    sh "terraform plan -input=false -var-file=${env.TFVARS_FILE} -out=tfplan"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    echo "🚀 Running Terraform Apply..."
                    echo "--------------------------------"
                    sh "terraform apply -input=false -auto-approve tfplan"
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