node {
    stage('Install Prerequisite') {
        def nodeContainer = docker.image('node:16-buster-slim').inside('-p 3000:3000') {
            sh 'node -v'
        }
    }
    stage('Building Application') {
        nodeContainer.inside {
            sh 'npm install'
        }
    }
}