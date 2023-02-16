pipeline {
    agent any
    
    options {
        timestamps()
         ansiColor("xterm")
    }
     stages {
       stage('Image builder') {
         steps {
            sh 'docker-compose build'
            sh "git tag 1.0.${BUILD_NUMBER}"
            sh "docker tag ghcr.io/cmg1911/terraform ghcr.io/cmg1911/terraform:1.0.${BUILD_NUMBER}"
            sshagent(['github-ssh']) {
                sh "git push --tags"}
          }
        stage('Package') {
          steps {
             withCredentials([string(credentialsId: 'token-git', variable: 'CR_PAT')]) {
                sh "echo $CR_PAT | docker login ghcr.io -u CMG1911 --password-stdin"
                sh 'docker-compose push'
                sh "docker push ghcr.io/cmg1911/hello-terraform:1.0.${BUILD_NUMBER}"
                }
           }
        }   
           
        stage('Deploy') {
            steps {
                withAWS(credentials: 'carlos-aws') {
                    sshagent(['ssh-amazon']) {
                        sh 'terraform init'
                        sh 'terraform fmt'
                        sh 'terraform validate'
                        withCredentials([string(credentialsId: 'token-git', variable: 'CR_PAT')]) {
                           sh "echo $CR_PAT | docker login ghcr.io -u CMG1911 --password-stdin"  
                           sh 'terraform apply -auto-approve'
                        }
                    }                  
                }
             }
         }
           
         stage ('Ansible playbook call') {
            steps{
                 withAWS(credentials: 'carlos-aws') {
                     ansiblePlaybook credentialsId: 'ssh-amazon', inventory: 'aws_ec2.yml', playbook: 'ec2.yml', vaultCredentialsId: 'token-git'
                    }
                }
            }
    }
}

