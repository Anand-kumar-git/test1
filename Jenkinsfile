pipeline {
    agent any

    environment {
        DEV_REPO = "anand20003/dev"
        PROD_REPO = "anand20003/prod"
        IMAGE_TAG = "latest"
        BRANCH_NAME = "dev"   // change this to "main" when building main branch
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: "*/${BRANCH_NAME}"]],
                          userRemoteConfigs: [[url: 'https://github.com/Anand-kumar-git/test.git']]])
            }
        }

<<<<<<< HEAD
        stage('Build Docker Imge') {
=======
        stage('Build Docker Image') {
>>>>>>> db76a71a2c1b2124a0ef0c9e0eaaffd5ff98c7c2
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

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Docker-Hub',
                                                  usernameVariable: 'DOCKER_USER',
                                                  passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

<<<<<<< HEAD
        stage('Push Docker Image') {
=======
        stage('Push Docker Imag') {
>>>>>>> db76a71a2c1b2124a0ef0c9e0eaaffd5ff98c7c2
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

        stage('Deploy to AWS') {
            steps {
                script {
                    sh 'chmod +x deploy.sh'
                    sh './deploy.sh'
                }
            }
        }
    }
}
