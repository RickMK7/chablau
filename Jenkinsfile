pipeline{
    agent any 
    stages{
        stage('build Docker image'){
            steps{
                sh 'echo "executando o comando docker build"'
            }
        }
    }
    stages{
        stage('push Docker image'){
            steps{
                sh 'echo "executando o comando docker push"'
            }
        }
    }
    stages{
        stage('deploy no Kubernetes'){
            steps{
                sh 'echo "executando o comando kubectl apply"'
            }
        }
    }
}