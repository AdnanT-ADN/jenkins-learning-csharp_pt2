pipeline {
    agent any

    environment {
        DOCKER_IMG = "docker-csharp-testing"
        TEST_RESULTS_DIR = "TestResults"
    }

    stages {

        stage("Checkout") {
            steps {
                script {
                    deleteDir()
                }
                checkout scm
                sh "ls -la"
            }
        }

        stage("Check Versions: Docker, GIT") {
            steps {
                sh "docker --version"
                sh "git --version"
            }
        }

        stage("Build Docker Image") {
            steps {
                script {
                    echo "Building Docker Image"
                    sh "docker build -t $DOCKER_IMG -f DockerImages/Testing/Dockerfile ."
                }
            }
        }

        stage("Run Unit Tests") {
            steps {
                script {
                    sh "mkdir -p $WORKSPACE/$TEST_RESULTS_DIR"
                    sh "ls -la"
                }
            }
        } 

        stage("Archive Test Results") {
            steps {
                script {
                    echo "TODO Make this archive the test results in a .trx file to Jenkins"
                }
                sh "chmod -R 755 $TEST_RESULTS_DIR"
                sh "ls -la"
                sh "ls -la ./$TEST_RESULTS_DIR"
                sh "ls -la ./src"

                archiveArtifacts artifacts: "./$TEST_RESULTS_DIR", allowEmptyArchive: false
                junit testResults: "./$TEST_RESULTS_DIR/TestResults.trx", allowEmptyResults: false
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