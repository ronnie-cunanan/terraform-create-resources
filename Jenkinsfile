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
                    sh "terraform apply -input=false -auto-approve tfplan"

                    // Capture EC2 public IP
                    env.EC2_PUBLIC_IP = sh(
                        script: "terraform output -raw cicd_server_public_ip",
                        returnStdout: true
                    ).trim()

                    echo "🌐 EC2 Public IP: ${env.EC2_PUBLIC_IP}"
                }
            }
        }

        stage('Generate Ansible Inventory') {
            steps {
                script {
                    echo "📝 Generating Ansible inventory..."

                    writeFile file: "inventory.ini", text: """
[docker_host]
${env.EC2_PUBLIC_IP} ansible_user=ubuntu
"""

                    sh "cat inventory.ini"
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