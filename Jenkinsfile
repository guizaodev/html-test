pipeline {
    agent any
    
    stages {
        stage('Initialize'){
            steps{
                script{
                    def dockerHome = tool 'Docker'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                }
            }
        }
        
        stage('Build Image') {
            steps {
                script {
                    def dockerImage = docker.build('http-test2:latest', '.')
                }
            }
        }
        
        stage('Deploy Container') {
            steps {
                script {
                    // Parar e remover o container antigo, se existir
                    sh 'docker stop http-test2 || true'
                    sh 'docker rm http-test2 || true'
                    
                    // Iniciar um novo container com a imagem criada
                    sh 'docker run -d --name http-test2 -p 8444:80 http-test2:latest'
                }
            }
        }
    }
}
