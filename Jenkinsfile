pipeline {
  agent any
  
  tools {
    terraform 'Jenkins-terraform'
  }
   
  environment {
    AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    AWS_DEFAULT_REGION = 'us-east-1'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/chingari5268/De-provision.git'
      }
    }
  
    stage('Workspace') {
      steps {
        script {
          def workspaceAction = input(
            message: 'Do you want to create or destroy a Terraform workspace? (create/destroy)',
            parameters: [string(name: 'WorkspaceAction', defaultValue: 'create')]
          )
          if (workspaceAction == 'create') {
            def workspaceName = input(
              message: 'Enter the name of the Terraform workspace:',
              parameters: [string(name: 'WorkspaceName', defaultValue: 'default')]
            )
            sh "terraform workspace new $workspaceName"
          } else if (workspaceAction == 'destroy') {
            def workspaceName = input(
              message: 'Enter the name of the Terraform workspace you want to destroy:',
              parameters: [string(name: 'WorkspaceName')]
            )
            sh "terraform workspace select $workspaceName"
            sh "terraform workspace delete $workspaceName"
          } else {
            error("Invalid workspace action: $workspaceAction")
          }
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
        script {
          def agencyName = input(
            message: 'Enter the name of the agency:',
            parameters: [string(name: 'AgencyName')]
          )
          sh "terraform plan -var 'agencies=$agencyName' -out=tfplan"
        }
      }
    }
    
    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve tfplan'
      }
    }
    
    stage('Terraform Destroy') {
      steps {
        script {
          def destroy = input(
            message: 'Do you want to destroy the resources? (yes/no)',
            parameters: [string(name: 'Destroy', defaultValue: 'no')],
          )
          if (destroy == 'yes') {
            def agencyName = input(
              message: 'Enter the name of the agency:',
              parameters: [string(name: 'AgencyName')]
            )
            sh "terraform destroy -auto-approve -var 'agencies=$agencyName' 'force_destroy=true'"
          } else {
            echo 'Not destroying resources.'
          }
        }
      }
    }
  }
}
