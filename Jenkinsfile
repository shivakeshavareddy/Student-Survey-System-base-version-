pipeline {
	agent any
	environment {
		DOCKER_CREDS = credentials('docker')
		DOCKER_IMAGE_NAME = "parnavi/survey-form-image-gcp"
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
					img = docker.build "parnavi/survey-form-image-gcp:${env.BUILD_ID}"

					withDockerRegistry(credentialsId: 'docker', url: '') {
						echo "Creating docker image and pusing to docker hub ..."

						img.push "${env.BUILD_ID}"
					}
				}
			}
		}

	    
		stage("UpdateDeployment") {
			steps{
				sh 'gcloud container clusters get-credentials kube-cluster --zone us-east4-a'
				sh 'kubectl config view'
				sh "kubectl get deployments"
				sh "kubectl set image deployment/survey-form-gcp survey-form-image-gcp=parnavi/survey-form-image-gcp:${env.BUILD_ID}"
			}
			
		}
	}
}