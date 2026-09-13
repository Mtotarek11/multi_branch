pipeline {
    agent any

    environment {
        APP_NAME = 'new-app-nti' 
        REPO_URL = "https://github.com/Mtotarek11/multi_branch.git"
    }

    stages {
        stage('Getting Repo files') {
            steps {
                git branch: 'main', credentialsId: 'github-token', url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${APP_NAME}:${BUILD_NUMBER} -t ${APP_NAME}:latest ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker tag ${APP_NAME}:${BUILD_NUMBER} "$DOCKER_USERNAME/${APP_NAME}:${BUILD_NUMBER}"
                        docker tag ${APP_NAME}:latest "$DOCKER_USERNAME/${APP_NAME}:latest"
                        docker push "$DOCKER_USERNAME/${APP_NAME}:${BUILD_NUMBER}"
                        docker push "$DOCKER_USERNAME/${APP_NAME}:latest"
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
