pipeline {
    agent any
    
    options {
        timestamps()
    }

    stages {
        stage('Deploy') {
            steps {
                withAWS(credentials: 'carlos-aws') {
                    sshagent(['ssh-amazon']) {
                        sh 'terraform init'
                        sh 'terraform fmt'
                        sh 'terraform validate'
                        sh 'terraform apply -auto-approve'
                    }                  
                }
            }
        }
    }
}

