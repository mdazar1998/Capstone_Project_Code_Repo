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
                    sh 'docker tag myapp:$BUILD_NUMBER mdazar1998/capstone-project-prod-repo:latest'
                    
                    // Push the Docker image to Docker Hub repository
                    // capstone-project-repo/
                    sh 'docker push mdazar1998/capstone-project-prod-repo:latest'
                    // sh 'docker push myapp:latest'

                }
            }
        }
        stage('Copy into EC2 Instance') {
            steps {
                sshagent(['EC2']) {
                sh '''
			ssh -o StrictHostKeyChecking=no ubuntu@ip-172-31-8-107 'mkdir -p /home/ubunt/deploy'
			scp -o StrictHostKeyChecking=no deploy.sh ubuntu@ip-172-31-8-107:/home/ubuntu/deploy/deploy.sh
		'''
                }       
            }
        }
	    stage('Deploy into EC2 Instance') {
            steps {
                sshagent(['EC2']) {
                sh '''
			ssh -o StrictHostKeyChecking=no ubuntu@ip-172-31-8-107 'cd /home/ubuntu/deploy && chmod +x deploy.sh'
			sh -o StrictHostKeyChecking=no ubuntu@ip-172-31-8-107 'cd /home/ubuntu/deploy && ./deploy.sh'
		'''			
                } 
            }
        }
    }
}
