pipeline {
    agent any

    environment {
        DEV_REPO = "anand20003/dev"
        PROD_REPO = "anand20003/prod"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Cleanup Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'chmod +x build.sh'
                    sh './build.sh'

                    if (env.BRANCH_NAME == "dev") {
                        sh "docker tag static-web $DEV_REPO:$IMAGE_TAG"
                    } else if (env.BRANCH_NAME == "main") {
                        sh "docker tag static-web $PROD_REPO:$IMAGE_TAG"
                    }
                }
            }
        }

        stage('Login To DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Docker-Hub',
                                                  usernameVariable: 'DOCKER_USER',
                                                  passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == "dev") {
                        sh "docker push $DEV_REPO:$IMAGE_TAG"
                    } else if (env.BRANCH_NAME == "main") {
                        sh "docker push $PROD_REPO:$IMAGE_TAG"
                    }
                }
            }
        }

        stage('Deploy To AWS') {
            steps {
                script {
                    sh 'chmod +x deploy.sh'
                    sh './deploy.sh'
                }
            }
        }
    }
}
