pipeline {
    agent any

    environment {
        DEV_REPO   = "anand20003/dev"
        PROD_REPO  = "anand20003/prod"
        IMAGE_TAG  = "latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: "*/${env.BRANCH_NAME}"]],
                          userRemoteConfigs: [[url: 'https://github.com/Anand-kumar-git/test.git']]])
            }
        }

        stage('Build React App') {
            steps {
                script {
                    sh '''
                        echo "=== Installing Node.js dependencies ==="
                        npm install
                        
                        echo "=== Building React app ==="
                        npm run build
                        
                        echo "=== Build contents ==="
                        ls -l build
                    '''
                }
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
                    } else {
                        error "❌ Branch ${env.BRANCH_NAME} is not supported for Docker push"
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

        stage('Deploy to AWS') {
            steps {
                script {
                    sh 'chmod +x deploy.sh'
                    sh './deploy.sh'
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}
