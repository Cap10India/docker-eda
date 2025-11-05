pipeline {
    agent any

    parameters {
        string(
            name: 'CONTAINER_NAME',
            defaultValue: '',
            description: 'Enter a unique name for the Docker container (example: myapp-dev-01)'
        )
        string(
            name: 'APP_PORT',
            defaultValue: '',
            description: 'Enter the Port number to expose the container on (example: 8081)'
        )
    }

    environment {
        DOCKER_REPO = "edatest"    // Update this
        UNIQUE_TAG = "${env.BUILD_NUMBER}"   // Auto unique image tag
    }

    stages {

        stage('Validate Inputs') {
            steps {
                script {
                    if (!params.CONTAINER_NAME?.trim()) {
                        error "❌ CONTAINER_NAME is mandatory. Please provide a unique container name."
                    }

                    if (!params.APP_PORT?.trim().isInteger()) {
                        error "❌ APP_PORT should be a valid number."
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker Image with Unique Tag: ${UNIQUE_TAG}"
                    sh """
                        docker build -t ${DOCKER_REPO}:${UNIQUE_TAG} .
                    """
                }
            }
        }

        stage('Stop & Remove Existing Container (if same name exists)') {
            steps {
                script {
                    sh """
                        ID=\$(docker ps -aq --filter "name=^${params.CONTAINER_NAME}\$")
                        if [ ! -z "\$ID" ]; then
                          echo "Found container with same name. Stopping and removing..."
                          docker stop \$ID || true
                          docker rm \$ID || true
                        fi
                    """
                }
            }
        }
        stage('Create Docker Volume') {
            steps {
                script {
                    echo "Running Container: ${params.CONTAINER_NAME}"
                    sh """
                        docker volume create ${params.CONTAINER_NAME}_UL
                    """
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    echo "Running Container: ${params.CONTAINER_NAME}"
                    sh """
                        docker run -it -d --privileged --name=${CONTAINER_NAME}_UL_Desktop -v ${CONTAINER_NAME}_UL:/home/rocket -p ${APP_PORT}:3389 ${DOCKER_REPO}:${UNIQUE_TAG}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment Successful!"
            echo "Container Name: ${params.CONTAINER_NAME}"
            echo "Image Tag: ${UNIQUE_TAG}"
        }
        failure {
            echo "❌ Deployment Failed. Check logs."
        }
    }
}
