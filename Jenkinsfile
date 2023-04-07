pipeline {
  agent any
  
  tools {
        terraform 'Jenkins-terraform'
    }

  environment {
       AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
       ACCESS_SECRET_ACCESS_KEY = credentials('ACCESS_SECRET_ACCESS_KEY')
       AWS_DEFAULT_REGION = 'us-east-1'
  }

  stages {
    stage('Checkout') {
            steps {
               git branch: 'main' , url:'https://github.com/chingari5268/De-provision.git'
            }
        }
    stage('Terraform Destroy') {
      steps {
        script {
          sh 'terraform init'
          sh 'terraform destroy -auto-approve'
        }
      }
    }
  }
}
