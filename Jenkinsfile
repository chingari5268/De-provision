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
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Destroy') {
            steps {
                sh 'terraform destroy -auto-approve -target=aws_s3_bucket.myagencya-bucket1 -target=aws_s3_bucket_object.myagencya-bucket1_objects'
            }
        }
    }
}
