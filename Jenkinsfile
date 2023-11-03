node {
    try {
        stage('Checkout') {
            // You may want to checkout your code repository here
            // For example, if you're using Git:
            // checkout scm
        }

        stage('Install and Run Network Task') {
            // Define the Docker image to use
            def nodeImage = 'node:16-buster-slim'

            // Run the Docker container
            def nodeContainer = docker.image(nodeImage).run("-p 3000:3000")
            
            try {
                // Inside the container, install dependencies and run the network task
                nodeContainer.inside {
                    // Install Node.js project dependencies (e.g., npm or yarn)
                    sh 'npm install' // or 'yarn install' if you use Yarn

                    // Execute your network-related task here
                    // Example: Run a Node.js server or any other network-related operation
                    sh 'npm start' // Replace with your actual command
                }
            } finally {
                // Clean up and stop the Docker container
                nodeContainer.stop()
                nodeContainer.remove(force: true)
            }
        }
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    }
}