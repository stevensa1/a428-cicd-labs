node {
    try {
        def nodeImage = 'node:16-buster-slim'
        def nodeContainer = docker.image(nodeImage)

        stage('Install Dependencies and Network Task') {
            nodeContainer.inside {
                sh 'npm install'
            }
        }
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    }
}
