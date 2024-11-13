pipeline {
    agent any

    environment {
        DOCKER_IMG = "ms-cs-docker-test-1"
        TEST_RESULTS_DIR = "TestResults"
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

        // stage("Retrieve Test Results") {
        //     steps {
        //         script {
        //             echo "Retrieving Test Results from Docker Image"

        //             // Ensure the test results directory exists
        //             sh "mkdir -p $TEST_RESULTS_DIR"

        //             // Remove existing container if it exists
        //             sh "docker rm -f temp-container || true"

        //             // Create a new container and copy test results
        //             sh "docker create --name temp-container $DOCKER_IMG"
        //             sh "docker cp temp-container:/App/TestResults/TestResults.trx $TEST_RESULTS_DIR"
        //             sh "docker rm temp-container"
        //         }
        //     }
        // }

        stage("Run Unit Tests") {
            steps {
                // script {
                //     echo "TODO Make this run unit tests"
                //     sh "docker run --rm $DOCKER_IMG dotnet test /App/src"
                // }
                script {
                    echo "Running Unit Tests in Docker"
                    // Create a directory for storing test results
                    sh "mkdir -p ./$TEST_RESULTS_DIR"

                    // Run dotnet test inside the Docker container
                    sh """
                        docker run --rm \
                        -v $WORKSPACE/$TEST_RESULTS_DIR:/App/src/$TEST_RESULTS_DIR \
                        $DOCKER_IMG \
                        dotnet test /App/src -c Release --logger "trx;LogFileName=/App/src/$TEST_RESULTS_DIR/TestResults.trx"
                    """

                    // Debug: List contents of TestResults directory to confirm output
                    sh "ls -la $WORKSPACE/$TEST_RESULTS_DIR"
                    sh "cat $WORKSPACE/$TEST_RESULTS_DIR/TestResults.trx"
                }
            }
        } 

        stage("Archive Test Results") {
            steps {
                script {
                    echo "TODO Make this archive the test results in a .trx file to Jenkins"
                }
                sh "chmod -R 755 $TEST_RESULTS_DIR"

                archiveArtifacts artifacts: "$TEST_RESULTS_DIR/*.trx", allowEmptyArchive: 
                sh "ls -la"
                junit testResults: "$TEST_RESULTS_DIR/*.trx", allowEmptyResults: false
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