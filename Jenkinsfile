node ('cicd-pipeline-submission-stevensa1') {
    def nodeJs = 'node:16-buster-slim'
    triggers {
        pollSCM('H/2 * * * *')
    }
    stage('Build') {
        echo 'Building React Application Project...'
        try {
            docker.image(nodeJs).inside("-p 3000:3000") {
                sh 'npm install'
            }
        } catch (Exception e) {
            currentBuild.result = 'FAILURE'
            error "Build failed: ${e.message}"
        }
    }
    stage('Test') {
        echo 'Testing the build...'
        try {
            docker.image(nodeJs).inside("-p 3000:3000") {
                sh './jenkins/scripts/test.sh'
            }
        } catch (Exception e) {
            currentBuild.result = 'FAILURE'
            error "Test failed: ${e.message}"
        }
    }
}