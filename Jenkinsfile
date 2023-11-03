node {
  docker.withDockerContainer('node:16-buster-slim', '-p 3000:3000') {
    stage('Build') {
      sh 'npm install'
    }

    stage('Test') {
      sh './jenkins/scripts/test.sh'
    }
  }
}