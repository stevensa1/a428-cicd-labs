node {
    stage('Create and Start Container') {
        def nodeImage = 'node:16-buster-slim'
        def nodeContainer = docker.image(nodeImage).run("-p 3000:3000")

        stage('Install Dependencies and Prepare Network Task') {
            sh 'npm install'
        }
    }
}