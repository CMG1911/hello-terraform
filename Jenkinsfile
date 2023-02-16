pipeline {
    agent any
    
    options {
        timestamps()
    }

    stages {
        stage('Deploy') {
            steps {
                withAWS(credentials: 'carlos-aws') {
                    sshagent(['amazon-ssh']) {
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

