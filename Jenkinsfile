node {
    withDockerContainer(image: 'node:16-buster-slim', args: '-p 3000:3000') {
        stage('Build') {
            echo 'Building project..'
            try {
                sh 'npm install'
            } catch (Exception e) {
                currentBuild.result = 'FAILURE'
                error "Build failed: ${e.message}"
            }
        }
        stage('Test') {
            echo 'Testing the build..'
            try {
                sh './jenkins/scripts/test.sh'
            } catch (Exception e) {
                currentBuild.result = 'FAILURE'
                error "Test failed: ${e.message}"
            }
        }
    }
}