node {
    checkout scm
    withDockerContainer(image: 'node:16-buster-slim', args: '-p 3000:3000') {
        // stage('Build') {
        //     echo 'Building project..'
        //     try {
        //         sh 'npm install'
        //         sh 'npm run build'
        //     } catch (Exception e) {
        //         currentBuild.result = 'FAILURE'
        //         error "Build failed: ${e.message}"
        //     }
        // }
        // stage('Test') {
        //     echo 'Testing the build..'
        //     try {
        //         sh './jenkins/scripts/test.sh'
        //     } catch (Exception e) {
        //         currentBuild.result = 'FAILURE'
        //         error "Test failed: ${e.message}"
        //     }
        // }
        // stage('Manual Approval') {
        //    input message: 'Lanjutkan ke tahap Deploy?', parameters: [booleanParam(defaultValue: true, description: 'Klik "Proceed" untuk melanjutkan eksekusi pipeline ke tahap Deploy', name: 'Proceed')]
        // }
        // stage('Deploy') {
        //     echo 'Delivering artifact...'
        //     try {
        //         sh './jenkins/scripts/deliver.sh'
        //         sleep time: 60, unit: 'SECONDS'
        //         sh './jenkins/scripts/kill.sh'
        //     } catch (Exception e) {
        //         currentBuild.result = 'FAILURE'
        //         error "Test failed: ${e.message}"
        //     }
        // }
    }
    stage('Deliver') {
       input message: 'Deliver to EC2?'
       try {
        withCredentials([file(credentialsId: '1759702f-d204-4d3a-b9be-9c367665f7d4', variable: 'PEM_FILE')]) {
            sh "ssh-keygen -R ec2-54-251-168-251.ap-southeast-1.compute.amazonaws.com"

            sh 'ssh -i $PEM_FILE ubuntu@ec2-54-251-168-251.ap-southeast-1.compute.amazonaws.com \'cd ~/production_build && rm -r *\''
            if (sh(script: 'echo $?', returnStatus: true) != 0) {
                error "Failed to start the server on the EC2 instance."
            }
                
            sh 'scp -i $PEM_FILE -o StrictHostKeyChecking=no -r jenkins src public package.json ubuntu@ec2-54-251-168-251.ap-southeast-1.compute.amazonaws.com:~/production_build/'
            if (sh(script: 'echo $?', returnStatus: true) != 0) {
                error "Failed to copy files to the EC2 instance."
            }

            sh 'ssh -i $PEM_FILE ubuntu@ec2-54-251-168-251.ap-southeast-1.compute.amazonaws.com \'cd ~/production_build && npm install && npm run build && sudo pm2 serve 80 build --spa\''
            if (sh(script: 'echo $?', returnStatus: true) != 0) {
                error "Failed to start the server on the EC2 instance."
            }
            
            echo 'Application is deployed!'
            }
        } catch (Exception e) {
            currentBuild.result = 'FAILURE'
            error "Test failed: ${e.message}"
        }
    }
}