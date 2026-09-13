pipeline {
    agent any

    environment {
        APP_NAME = 'new-app-nti' 
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        docker build -t ${APP_NAME}:${BUILD_NUMBER} -t ${APP_NAME}:latest .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh """
                        echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
                        docker tag ${APP_NAME}:${BUILD_NUMBER} ${DOCKER_USERNAME}/${APP_NAME}:${BUILD_NUMBER}
                        docker tag ${APP_NAME}:latest ${DOCKER_USERNAME}/${APP_NAME}:latest
                        docker push ${DOCKER_USERNAME}/${APP_NAME}:${BUILD_NUMBER}
                        docker push ${DOCKER_USERNAME}/${APP_NAME}:latest
                    """
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
