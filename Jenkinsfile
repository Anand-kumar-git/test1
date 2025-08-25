pipeline {
    agent any

    environment {
        DEV_REPO = "anand20003/dev"
        PROD_REPO = "anand20003/prod"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def repo = (env.BRANCH_NAME == "main") ? PROD_REPO : DEV_REPO
                    sh """
                        docker build -t ${repo}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    def repo = (env.BRANCH_NAME == "main") ? PROD_REPO : DEV_REPO
                    sh """
                        echo "${DOCKERHUB_PASSWORD}" | docker login -u "${DOCKERHUB_USERNAME}" --password-stdin
                        docker push ${repo}:${IMAGE_TAG}
                    """
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh """
                        docker rm -f static_application || true
                        docker run -d -p 9091:80 --name static_application ${ (env.BRANCH_NAME == "main") ? PROD_REPO : DEV_REPO }:${IMAGE_TAG}
                    """
                }
            }
        }
    }
}
