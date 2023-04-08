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
        git branch: 'main', url: 'https://github.com/chingari5268/De-provision.git'
      }
    }

    stage('Create or Destroy Workspace') {
      steps {
        script {
          def destroy = input(
            message: 'Do you want to create or destroy the Terraform workspace? (create/destroy)',
            parameters: [string(name: 'Destroy', defaultValue: 'create')]
          )

          if (destroy == 'create') {
            def agencyName = input(
              message: 'Enter the name of the agency for the Terraform workspace:',
              parameters: [string(name: 'AgencyName', defaultValue: 'default')]
            )
            sh "terraform workspace new $agencyName"
          } else {
            def agencyName = input(
              message: 'Enter the name of the agency for the Terraform workspace:',
              parameters: [string(name: 'AgencyName', defaultValue: 'default')]
            )
            sh "terraform workspace select $agencyName"
            sh 'terraform destroy -auto-approve'
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
        sh 'terraform apply -auto-approve'
      }
    }
  }
}
