pipeline {
    agent any
 
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Image') {
            steps {
                script {
                    echo 'Iniciando a construção da imagem'
                    // Construindo a imagem Docker
                    dockerapp = docker.build("registry.tools.havan.com.br/devops/node-pokemon:${env.BUILD_ID}", '-f ./src/Dockerfile ./src')
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    // Fazendo push da imagem para o registro
                    docker.withRegistry('https://registry.tools.havan.com.br/', 'havan-registry-credentials') {
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            environment {
                tag_version = "${env.BUILD_ID}" // Usando o BUILD_ID como versão da tag
            }
            steps {
                script {
                    // Listar arquivos para depuração
                    sh 'ls -R .'
 
                    // Atualiza a tag da imagem no values.yaml
                    sh "sed -i 's/tag: .*/tag: ${tag_version}/' ./my-chart/values.yaml"
 
                    withKubeConfig([credentialsId: 'kubeconfig']) {
                        sh 'kubectl get pods --namespace jahdouglas'
                        // Realiza o deployment usando o Helm
                        echo 'Realizando o deploy com Helm'
                        sh 'helm upgrade --install pokemon-release ./my-chart --namespace jahdouglas'
                    }
                }
            }
        }
    }
}