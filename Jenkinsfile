pipeline {
    agent { label "swayam"}

    stages {
        stage('clone') {
            steps{
                echo "Clonning the app....."
                git url: "https://github.com/priyanshu3103/system-utilization--using-flask.git", branch: "main"
                echo "Successfully cloned"
            }
            
        }
        stage('Build') {
             steps{
                echo "Building the app....."
                sh "sudo usermod -aG docker $USER && newgrp docker"
                sh "sudo chown $USER /var/run/docker.sock"
                sh "docker build . -t systemutil:02"
                echo "Image build successfully"
            }
            
        }
        stage('Push') {
             steps{
                echo "Pushing image on github....."
                withCredentials([usernamePassword('credentialsId':"DockerHubCred", passwordVariable:"DockerHubPass", usernameVariable:"DockerHubUser")]){
                    sh "docker login -u ${env.DockerHubUser} -p ${env.DockerHubPass}"
                    sh "docker image tag systemutil:02 ${env.DockerHubUser}/systemutil:02"
                    sh "docker push ${env.DockerHubUser}/systemutil:02"
                    echo "Login successed and Image push successfully on DockerHub"
                }
                
                
                
            }
            
        }
        stage('Deploy') {
             steps{
                echo "Deploy the app....."
                sh "sudo apt update"
                sh "sudo apt-get install docker-compose -y"
                sh "docker-compose down && docker-compose up -d "
                echo "Depolyment successed"
            }
            
        }
        stage('Clean'){
            steps{
                sh "docker system prune -f"
                
            }
        }
    }
}
