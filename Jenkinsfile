node {
    try {
        stage('Create and Start Container') {
            def nodeImage = 'node:16-buster-slim'
            def nodeContainer = docker.image(nodeImage).withRun("-p 3000:3000")
        }

        stage('Install Dependencies and Prepare Network Task') {
            nodeContainer.inside {
                sh 'npm install'
            }
        }
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    }
}