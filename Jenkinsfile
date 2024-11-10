pipeline {
    agent any 

    environment {
        DOCKERHUB_USERNAME = "shashidas"
        GIT_REPO = "https://github.com/shashidas95/mern-todo-app"
        CONFIG_PROJECT_NAME = "mern-todo-app-conf"
        IMAGE_TAG = new Date().format('yyyyMMdd-HHmm') 
        IMAGE_BE = "mern-todo-be"
        IMAGE_FE = "mern-todo-fe"
    }
     
    stages {
        stage('CLEANUP WORKSPACE') {
            steps {
                cleanWs()
            }
        }

        stage("CHECKOUT GIT REPO") {
            steps {
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Check Docker') {
            steps {
                sh 'echo $PATH'
                sh 'docker --version'
            }
        }

        stage("BUILD DOCKER IMAGES") {
            steps {
                script {
                    // Build backend image
                    dir('backend') {
                        sh "docker build --no-cache  -t ${DOCKERHUB_USERNAME}/${IMAGE_BE}:${IMAGE_TAG} -t ${DOCKERHUB_USERNAME}/${IMAGE_BE}:latest ."
                    }
                    
                    // Build frontend image
                    dir('frontend') {
                        sh "docker build --no-cache  -t ${DOCKERHUB_USERNAME}/${IMAGE_FE}:${IMAGE_TAG} -t ${DOCKERHUB_USERNAME}/${IMAGE_FE}:latest ."
                    }
                }
            }
        }

        stage("PUSH DOCKER IMAGES TO DOCKERHUB") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USER_NAME')]) {
                    sh 'echo ${PASSWORD} | docker login --username ${USER_NAME} --password-stdin'
                    
                    // Push backend image with both tags
                    sh "docker push ${DOCKERHUB_USERNAME}/${IMAGE_BE}:${IMAGE_TAG}"
                    sh "docker push ${DOCKERHUB_USERNAME}/${IMAGE_BE}:latest"
                    
                    // Push frontend image with both tags
                    sh "docker push ${DOCKERHUB_USERNAME}/${IMAGE_FE}:${IMAGE_TAG}"
                    sh "docker push ${DOCKERHUB_USERNAME}/${IMAGE_FE}:latest"

                    sh 'docker logout'
                }
            }
        }

        stage("TRIGGERING THE CONFIG PIPELINE") {
            steps {
                // Trigger the config pipeline for backend and frontend
                build job: CONFIG_PROJECT_NAME, parameters: [string(name: 'IMAGE_TAG', value: IMAGE_TAG)]
            }
        }
                stage("CLEANUP DOCKER CACHES AND IMAGES") {
            steps {
                script {
                    // Remove all Docker images
                    sh 'docker system prune -af --volumes'
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully with cleanup'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
