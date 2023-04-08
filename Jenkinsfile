pipeline {
  agent any
  
  tools {
        terraform 'Jenkins-terraform'
  }
   
  environment {
    AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    AWS_DEFAULT_REGION = 'eu-west-1'
  }

  stages {
    stage('Checkout') {
      steps {
         git branch: 'main' , url:'https://github.com/chingari5268/De-provision.git'
      }
    }
  
  stages {
    stage('Create Workspace') {
      steps {
        script {
          def workspaceName = input(
            message: 'Enter the name of the Terraform workspace:',
            parameters: [string(name: 'WorkspaceName', defaultValue: 'default')]
          )
          sh "terraform workspace new $workspaceName"
        }
      }
    }
	stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }
    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
    stage('Destroy Workspace') {
      steps {
        script {
          def destroy = input(
            message: 'Do you want to destroy the resources? (yes/no)',
            parameters: [string(name: 'Destroy', defaultValue: 'no')]
          )
          if (destroy == 'yes') {
            sh 'terraform destroy -auto-approve'
          } else {
            echo 'Not destroying resources.'
          }
        }
      }
    }
  }
}
