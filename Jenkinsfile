node {
    try {
        def nodeImage = 'node:16-buster-slim'
        def nodeContainer = docker.image(nodeImage).run("-p 3000:3000")
        
        try {
            stage('Build') {
                nodeContainer.inside {
                    sh 'npm install'
                }
            }
        } finally {
            nodeContainer.stop()
        }
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    }
}
