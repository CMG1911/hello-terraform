pipeline {
    agent any
    options{timestamps()}
    stages {
        stage('Image builder') {
         steps {
            sh 'docker-compose build'
            sh "git tag 1.0.${BUILD_NUMBER}"
            sh "docker tag ghcr.io/cmg1911/hello-2048 ghcr.io/cmg1911/hello-2048:1.0.${BUILD_NUMBER}"
            sshagent(['github-ssh']) {
                sh "git push --tags"}
          }
        }
             
         stage('Package') {
          steps {
             withCredentials([string(credentialsId: 'token-git', variable: 'CR_PAT')]) {
                sh "echo $CR_PAT | docker login ghcr.io -u CMG1911 --password-stdin"
                sh 'docker-compose push'
                sh "docker push ghcr.io/cmg1911/hello-2048:1.0.${BUILD_NUMBER}"
                }
           }
        }

        stage('Connection') {
         steps {sshagent(['ssh-amazon']) {
                 sh 'ssh -o "StrictHostKeyChecking no" ec2-user@ec2-54-195-160-88.eu-west-1.compute.amazonaws.com docker pull ghcr.io/cmg1911/hello-2048:1.0.${BUILD_NUMBER}'
                 sh 'ssh -o "StrictHostKeyChecking no" ec2-user@ec2-54-195-160-88.eu-west-1.compute.amazonaws.com docker-compose up -d' }
                }
        }
    }
}
