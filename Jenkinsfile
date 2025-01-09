pipeline {
    agent {
        docker { image 'mcr.microsoft.com/dotnet/sdk:8.0' }
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

        stage("Build") {
            steps {
                script {
                    docker.build("build-image", "-f ./DockerImages/Dockerfile.build .")
                }
            }
        }

        stage("Test") {
            steps {
                script {
                    docker.build("test-image", "-f ./DockerImages/Dockerfile.test .")
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
            echo "Pipeline Failed"
        }
    }


}