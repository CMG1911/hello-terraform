pipeline {
    agent any
    
    options {
        timestamps()
    }

    stages {
        stage('Deploy') {
            steps {
                withAWS(credentials: 'ruben-aws-credentials') {
                    sh 'terraform -chdir=./terraform init'
                    sshagent(['amazon-ssh']) {
                        sh 'terraform -chdir=./terraform fmt'
                        sh 'terraform -chdir=./terraform validate'
                        sh 'terraform -chdir=./terraform apply -auto-approve'
                    }                  
                }
            }
        }
    }
}

