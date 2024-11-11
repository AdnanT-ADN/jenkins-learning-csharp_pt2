pipeline {
    agent any

    environment {
        DOCKER_IMG = "ms-cs-docker-test-1"
    }

    stages {

        stage("Checkout") {
            steps {
                checkout scm
            }
        }

        stage("Test Docker and GIT") {
            steps {
                sh "docker --version"
                sh "git --version"
            }
        }

        stage("Build Docker Image") {
            steps {
                script {
                    echo "Building Docker Image"
                    sh "docker build -t $DOCKER_IMG -f Dockerfile ."
                }
            }
        }

        stage("Run Unit Tests") {
            steps {
                // script {
                //     echo "TODO Make this run unit tests"
                //     sh "docker run --rm $DOCKER_IMG dotnet test /App/src"
                // }
                script {
                    echo "Running Unit Tests in Docker"
                    // Create a directory for storing test results
                    sh "mkdir -p TestResults"

                    // Run dotnet test inside the Docker container
                    sh """
                        docker run --rm \
                        -v $WORKSPACE/TestResults:/App/src/TestResults \
                        $DOCKER_IMG \
                        dotnet test /App/src -c Release --logger "trx;LogFileName=/App/src/TestResults/TestResults.trx"
                    """
                }
            }
        }

        stage("Archive Test Results") {
            steps {
                script {
                    echo "TODO Make this archive the test results in a .trx file to Jenkings"
                }
            }
        }

        stage("Clean Up") {
            steps {
                script {
                    echo "Cleaning Docker Images"
                    sh "docker rmi $DOCKER_IMG"
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning Docker Containers"
            sh "docker system prune -f"
        }

        success {
            echo "Pipeline Completed Successfully"
        }

        failure {
            echo "Pipleline Failed"
        }
    }
}