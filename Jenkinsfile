pipeline {
	agent any
	environment {
		DOCKER_CREDS = credentials('pop')
		DOCKER_IMAGE_NAME = "parnavi/image-keshav"
		img = ''
	}
    stages {
	
        stage('BuildWAR') {
            steps {
				echo 'Creating the Jar ...'
				sh 'java -version'
				sh 'jar -cvf surveyform.war -C src/ index.html -C src/ surveyform.css'
            }
        }
		
		stage("BuildPublishImage"){
			steps {
				script {
					echo "${env.BUILD_ID}"
					img = docker.build "parnavi/image-keshav:${env.BUILD_ID}"

					withDockerRegistry(credentialsId: 'pop', url: '') {
						echo "Creating docker image and pusing to docker hub ..."

						img.push "${env.BUILD_ID}"
					}
				}
			}
		}

	    
		stage("UpdateDeployment") {
			steps{
				sh 'gcloud container clusters get-credentials fc --zone us-east1-b'
				sh 'kubectl config view'
				sh "kubectl get deployments"
				sh "kubectl set image deployment/dep-one image-keshav=parnavi/image-keshav:${env.BUILD_ID}"
			}
			
		}
	}
}
