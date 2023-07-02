pipeline {
    agent any

    stages {
        stage('Build and Push') {
            when {
                branch 'master'
            }
            steps {
                script {
                    // Build and push Docker image to Docker Hub
                    docker.build('myapp:latest').push('mydockerhub/myapp:latest')
                }
            }
        }
        stage('Build and Push Dev') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    // Build and push Docker image to Docker Hub
                    docker.build('myapp:dev').push('mydockerhub/myapp:dev')
                }
            }
        }
    }

    post {
        always {
            // Cleanup Docker resources
            cleanWs()
        }
    }
}
