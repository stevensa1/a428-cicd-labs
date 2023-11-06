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
       sh 'apt-get update'
       sh 'apt-get install -y openssh-client'
       withCredentials([file(credentialsId: 'b6d06e6a-fa99-42dd-b0be-1f04486a2723', variable: 'PEM_FILE')]) {
            sh "scp -i \$PEM_FILE -o StrictHostKeyChecking=no -r . ubuntu@ec2-54-208-51-83.compute-1.amazonaws.com:/production_build"
            sh "ssh -i \$PEM_FILE ubuntu@ec2-54-208-51-83.compute-1.amazonaws.com 'cd /production_build && ./jenkins/scripts/deliver.sh'"
            echo 'Application is deployed!'
       }
    }
}