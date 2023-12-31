pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your source code from Git
                git branch: 'master', credentialsId: 'git', url: 'https://github.com/mdazar1998/Capstone_Project_Code_Repo.git'
            }
        }

        stage('Build application') {
            steps {
                // Build the Docker image using build.sh script
                sh './build.sh $BUILD_NUMBER'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                // Login to Docker Hub
                withDockerRegistry([credentialsId: 'dockerhub_credentials', url: '']) {
                    // Tag the Docker image
                    sh 'docker tag myapp:$BUILD_NUMBER mdazar1998/capstone-project-dev-repo:latest'
                    // Push the Docker image to Docker Hub repository
                    sh 'docker push mdazar1998/capstone-project-dev-repo:latest'
                }
            }
        }
        stage('Pull and Push Docker hub') {
            steps {
                // Login to Docker Hub
                withDockerRegistry([credentialsId: 'dockerhub_credentials', url: '']) {
                    // Tag the Docker image
                    sh 'docker pull mdazar1998/capstone-project-dev-repo:latest'
                    sh 'docker tag mdazar1998/capstone-project-dev-repo:latest mdazar1998/capstone-prod-repo:latest'
                    // Push the Docker image to Docker Hub repository
                    sh 'docker push mdazar1998/capstone-project-prod-repo:latest'
                }
            }
        }
        stage('Copy the file to prod instance') {
            steps {
                sshagent(['EC2']) {
                sh '''
			    ssh -o StrictHostKeyChecking=no ubuntu@ip-172-31-8-107 'mkdir -p /home/ubuntu/deploy'
			    scp -o StrictHostKeyChecking=no deploy.sh ubuntu@ip-172-31-8-107:/home/ubuntu/deploy/deploy.sh
		        '''
                }       
            }
        }
	    stage('Deploy the Container in prod instance') {
            steps {
                sshagent(['EC2']) {
                sh '''
			    ssh -o StrictHostKeyChecking=no ubuntu@ip-172-31-8-107 'cd /home/ubuntu/deploy && chmod +x deploy.sh'
			    ssh -o StrictHostKeyChecking=no ubuntu@ip-172-31-8-107 'cd /home/ubuntu/deploy && ./deploy.sh'
		        '''			
                } 
            }
        }
    }
}
