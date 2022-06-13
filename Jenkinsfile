pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                  sh 'aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 797568759896.dkr.ecr.ap-southeast-1.amazonaws.com'
                  sh 'docker build -t cd-tts .'
//                  sh 'docker save cd-tts | bzip2 | aws s3 cp - s3://cd-registry/images/cd-tts.bin'
            }
        }
    }
}
