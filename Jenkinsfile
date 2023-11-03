node {
    try {

        stage('Install and Run Network Task') {
            
            def nodeImage = 'node:16-buster-slim'
            def nodeContainer = docker.image(nodeImage).run("-p 3000:3000")
            
            try {
                nodeContainer.inside {
                   sh 'npm install'
                }
            } finally {
                echo 'Install Success!'
            }
        }
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    }
}