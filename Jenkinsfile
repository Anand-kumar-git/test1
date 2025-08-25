pipeline {
    agent any

    environment {
        DEV_REPO   = "anand20003/dev"
        PROD_REPO  = "anand20003/prod"
        IMAGE_TAG  = "latest"
    }

    stages {
        stage('Checkout React App') {
            steps {
                dir('app') {
                    git branch: "${env.BRANCH_NAME}",
                        url: 'https://github.com/Anand-kumar-git/test.git'
                }
            }
        }

        stage('Build React App') {
            steps {
                dir('app') {
                    sh '''
                        echo "Installing dependencies..."
                        npm install
                        echo "Building React app..."
                        npm run build
                        echo "Build complete. Checking contents..."
                        ls -l build
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'chmod +x app/build.sh'
                    sh './app/build.sh'

                    if (env.BRANCH_NAME == "dev") {
                        sh "docker tag static-web $DEV_REPO:$IMAGE_TAG"
                    } else if (env.BRANCH_NAME == "main") {
                        sh "docker tag static-web $PROD_REPO:$IMAGE_TAG"
                    } else {
                        error "Branch ${env.BRANCH_NAME} is not supported for Docker push"
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
                    sh 'chmod +x app/deploy.sh'
                    sh './app/deploy.sh'
                }
            }
        }
    }
}
