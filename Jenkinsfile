node {
    withDockerContainer(image: 'node:16-buster-slim', args: '-p 3000:3000') {
        checkout scm
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
        stage('Manual Approval') {
           input message: 'Lanjutkan ke tahap Deploy?', parameters: [booleanParam(defaultValue: true, description: 'Klik "Proceed" untuk melanjutkan eksekusi pipeline ke tahap Deploy', name: 'Proceed')]
        }
        stage('Deploy') {
            echo 'Delivering artifact...'
            try {
                sh './jenkins/scripts/deliver.sh'
                sleep time: 60, unit: 'SECONDS'
                sh './jenkins/scripts/kill.sh'
            } catch (Exception e) {
                currentBuild.result = 'FAILURE'
                error "Test failed: ${e.message}"
            }
        }
    }
}