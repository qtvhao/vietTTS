pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                  aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 797568759896.dkr.ecr.ap-southeast-1.amazonaws.com
                  docker build -t cd-tts .
                  docker tag cd-tts:latest 797568759896.dkr.ecr.ap-southeast-1.amazonaws.com/cd-tts:latest
                  docker push 797568759896.dkr.ecr.ap-southeast-1.amazonaws.com/cd-tts:latest
            }
        }
    }
}

