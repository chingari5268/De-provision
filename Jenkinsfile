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
        sh 'terraform plan -out=tfplan'
      }
    }
    
    stage('Terraform Apply') {
      steps {
        script {
          def agencyName = input(
            message: 'Enter the name of the agency:',
            parameters: [string(name: 'AgencyName')]
          )
          sh "terraform apply -auto-approve -var 'agency_name=$agencyName'"
        }
      }
    }
    
    stage('Terraform Destroy') {
      steps {
        script {
          def destroy = input(
            message: 'message: 'Destroy the resources of the agency? (yes/no)',
            parameters: [string(name: 'AgencyName', defaultValue: 'no')]
          )
          if (destroy == 'yes') {
            sh "terraform destroy -auto-approve -var 'agency_name=$agencyName'"
          } else {
            echo 'Not destroying resources.'
          }
        }
      }
    }
  }
}
