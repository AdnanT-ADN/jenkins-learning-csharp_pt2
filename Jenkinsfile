pipeline {
    agent any

    environment {
        DOCKER_IMG = "docker-csharp-testing"
        TEST_RESULTS_DIR = "output"
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
                    sh "mkdir -p ${TEST_RESULTS_DIR}"
                    // sh "mkdir -p ${pwd}/${TEST_RESULTS_DIR}"
                    sh "docker build --no-cache -t ${DOCKER_IMG} -f DockerImages/Testing/Dockerfile ."
                    // sh "docker run --name dotnet-test-con ${DOCKER_IMG} || true"
                    sh "docker images"
                    sh "docker run -v ${pwd}/${TEST_RESULTS_DIR} --name dotnet-test-con ${DOCKER_IMG}"
                    // Copy test results from the container to the workspace
                    sh "docker ps -a"
                    sh "docker cp dotnet-test-con:/output ./output"
                    sh "docker rm dotnet-test-con"
                    // sh "docker exec dotnet-test-con ls -la /output"
                    // sh "docker cp ${DOCKER_IMG}:/output/test-results.trx ${TEST_RESULTS_DIR}/test-results.trx"sh "ls -la"
                }
            }
        }

        stage("Run Unit Tests") {
            steps {
                script {
                    // sh "mkdir -p $WORKSPACE/$TEST_RESULTS_DIR"
                    sh "ls -la"
                }
            }
        } 

        stage("Archive Test Results") {
            steps {
                script {
                    // Define the output directory where test results are generated
                    
                    // Ensure directory exists and set proper permissions
                    sh "mkdir -p ${TEST_RESULTS_DIR}/output"
                    sh "chmod -R 755 ${TEST_RESULTS_DIR}"
                    
                    // Debug: List the files in the output directory
                    sh "ls -la"
                    sh "ls -la ${TEST_RESULTS_DIR}/output"
                    sh "ls -la ${TEST_RESULTS_DIR}/output/test-results.xml"
                    
                    
                    // Archive the test results (.trx file) in Jenkins
                    archiveArtifacts artifacts: "${TEST_RESULTS_DIR}/output/*trx", allowEmptyArchive: false
                    sh "ls -la ${WORKSPACE}/${TEST_RESULTS_DIR}/output"
                    sh "cat ${WORKSPACE}/${TEST_RESULTS_DIR}/output/test-results.xml"
                    
                    // Publish the test results in Jenkins
                    junit testResults: "${WORKSPACE}/${TEST_RESULTS_DIR}/output/*.xml", allowEmptyResults: false
                }
            }
        }
         // stage("Archive Test Results") {
            //     steps {
            //         script {
            //             echo "TODO Make this archive the test results in a .trx file to Jenkins"
            //         }
            //         sh "chmod -R 755 $TEST_RESULTS_DIR"
            //         sh "ls -la"
            //         sh "ls -la ./$TEST_RESULTS_DIR"

            //         archiveArtifacts artifacts: "./$TEST_RESULTS_DIR", allowEmptyArchive: false
            //         junit testResults: "./$TEST_RESULTS_DIR/TestResults.trx", allowEmptyResults: false
            //     }
            // }

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