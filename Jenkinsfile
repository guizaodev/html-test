pipeline {
    agent any

    stages {
        stage('Initialize') {
            steps {
                withCredentials([string(credentialsId: 'github-status', variable: 'GITHUB_TOKEN')]) {
                    setGitHubStatus('pending', 'Deployment started')
                }
                script {
                    def dockerHome = tool 'Docker'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                }
            }
        }

        stage('Build Image') {
            steps {
                script {
                    try {
                        def dockerImage = docker.build('http-test2:latest', '.')
                    } catch (Exception e) {
                        setGitHubStatus('failure', 'Build failed')
                        error("Falha na construção da imagem Docker: ${e.getMessage()}") 
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Parar e remover o container antigo
                    sh 'docker stop http-test2'
                    sh 'docker rm http-test2'

                    // Iniciar um novo container com a imagem criada
                    sh 'docker run -d --name http-test2 -p 8444:80 http-test2:latest'
                }
            }
        }
    }

    post {
        success {
            withCredentials([string(credentialsId: 'github-status', variable: 'GITHUB_TOKEN')]) {
                setGitHubStatus('success', 'Deployment succeeded')
            }
        }
        failure {
            withCredentials([string(credentialsId: 'github-status', variable: 'GITHUB_TOKEN')]) {
                setGitHubStatus('failure', 'Deployment failed')
            }
        }
        aborted {
            withCredentials([string(credentialsId: 'github-status', variable: 'GITHUB_TOKEN')]) {
                setGitHubStatus('error', 'Deployment aborted')
            }
        }
        unstable {
            withCredentials([string(credentialsId: 'github-status', variable: 'GITHUB_TOKEN')]) {
                setGitHubStatus('failure', 'Deployment unstable')
            }
        }
    }
}