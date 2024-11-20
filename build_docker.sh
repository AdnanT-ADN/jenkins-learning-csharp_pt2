docker build -t ms-cs-docker-test-1 -f Dockerfile .


# Run Jenkins-DIND
# sudo chmod 666 /var/run/docker.sock

# docker run -d --name jenkins-dind -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins-dind
