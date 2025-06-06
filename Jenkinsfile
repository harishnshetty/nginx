pipeline {
    agent { label 'host' }

    environment {
        IMAGE_NAME = 'custom-nginx'
        CONTAINER_NAME = 'custom-nginx-container'
        GIT_REPO = 'https://github.com/harishnshetty/nginx.git'  // <-- change this
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: "${env.GIT_REPO}", branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                    sh "ls -lart"
                }
            }
        }

        stage('Remove Existing Container') {
            steps {
                script {
                    sh """
                        if [ \$(docker ps -a -q -f name=${CONTAINER_NAME}) ]; then
                            docker rm -f ${CONTAINER_NAME}
                        fi
                    """
                }
            }
        }

        stage('Clean Up Dangling Images') {
    steps {
        script {
            sh "docker image prune -f"
        }
    }
}

        stage('Run New Container') {
            steps {
                script {
                    sh "docker run -d --name ${CONTAINER_NAME} -p 80:80 ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        failure {
            echo 'Build failed.'
        }
        success {
            echo 'Container started successfully.'
        }
    }
}
