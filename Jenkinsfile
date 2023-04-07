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
         git branch: 'main' , url:'https://github.com/chingari5268/Terraformcheck.git'
      }
    }

    stage('Terraform Destroy') {
      steps {
        sh 'terraform destroy -target=aws_s3_bucket.myagencya-bucket1 -auto-approve'
      }
      sh 'aws s3 rm s3://myagencya-bucket1 --recursive'
    }
  }	
}
