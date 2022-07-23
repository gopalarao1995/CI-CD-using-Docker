pipeline {
    agent any
	
	  tools
    {
       jdk 'myjava'
       maven "mymvn"
    }
 stages {
      stage('checkout') {
           steps {
             
                git branch: 'master', url: 'https://github.com/gopalarao1995/CI-CD-using-Docker.git'
             
          }
        }
	 stage('Execute Maven') {
           steps {
             
                sh 'mvn clean install'             
          }
        }
        

  stage('Docker Build and Tag') {
           steps {
              
                sh 'docker build -t samplewebapp-01:$BUILD_NUMBER .' 
                sh 'docker tag samplewebapp-01:$BUILD_NUMBER goplarao/samplewebapp-01:$BUILD_NUMBER'
                //sh 'docker tag samplewebapp nikhilnidhi/samplewebapp:$BUILD_NUMBER'
               
          }
        }
        stage(' push to dockerhub') {
           steps {
               script{
                   withCredentials([string(credentialsId: 'docker_id', variable: 'dockercred')]) {
                  sh 'docker login -u goplarao -p ${dockercred}'
                                
                    sh  'docker push  goplarao/samplewebapp-01:$BUILD_NUMBER'
                   sh  'docker rmi -f samplewebapp-01:$BUILD_NUMBER goplarao/samplewebapp-01:$BUILD_NUMBER  '
                //sh 'docker tag samplewebapp nikhilnidhi/samplewebapp:$BUILD_NUMBER'e
                   }
                }
            }

          
        }
        stage('Depolying in eks cluster ') {
           steps {
                  withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: '', contextName: '', credentialsId: 'eks_config', namespace: '', serverUrl: '']]) {
                    sh  'docker pull  goplarao/samplewebapp-01:$BUILD_NUMBER'
                    sh 'kubectl apply -f deployment.yaml'
                    sh  'docker rmi -f goplarao/samplewebapp-01:$BUILD_NUMBER  '
                   }
               }
               
               
        }
          
    }
        
        
} 
