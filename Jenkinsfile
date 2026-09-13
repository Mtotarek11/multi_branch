pipeline {
    agent any

    environment {
        APP_NAME = 'new-app-nti' 
        REPO_URL = "https://github.com/MohamedMagdy840/jenkins-repo.git"
    }

    stages {
        stage('Getting Repo files') {
            steps {
                // لو Job عادية وليست Multibranch، يفضل تحديد اسم البرانش صريحاً مثل main
                git branch: 'main', credentialsId: 'jenkins', url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${APP_NAME}:${BUILD_NUMBER} -t ${APP_NAME}:latest ."
            }
        }

        stage('Push Docker Image') {
            steps {
                // لو الكريدنشال عندك مسجلة في جينكس بـ ID قيمته 'docker' بدل 'docker-hub-credentials'، غيرها هنا
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
