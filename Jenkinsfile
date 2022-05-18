pipeline {

    agent any

    environment {
        INPUT_SERVER=""
        INPUT_APP_VERSION=""
    }

    stages {

        stage("Interactive Input") {
            steps {
                script {

                    // Get the input
                    def userInput = input(
                            id: 'userInput', message: 'Enter path of test reports:?',
                            parameters: [
                                [$class: 'ChoiceParameterDefinition',
                    choices: ['Ubuntu_18_04','Amazon_Linux_2'].join('\n'),
                    name: 'Server',
                    description: 'Select the Operating System'],
                                [$class: 'ChoiceParameterDefinition',
                    choices: ['v1','v2'].join('\n'),
                    name: 'AppVersion',
                    description: 'Select Your App Version']
                            ])

                    // Save to variables. Default to empty string if not found.
                    INPUT_SERVER = userInput.Server?:''
                    INPUT_APP_VERSION = userInput.AppVersion?:''

                    // Echo to console
                    echo("Selected Server: ${INPUT_SERVER}")
                    echo("Selected Version: ${INPUT_APP_VERSION}")
                }
            }
        }
        stage("Create Server and App") {
            steps {
                echo 'Creating Prod Server via Terraform...'
                sh "rm -rf bookstore*"
                sh "git clone https://github.com/joshuatallman/bookstore-project.git"
                sh "cd ./bookstore-project/${INPUT_SERVER}"
                sh "sed -i 's/branchX/${INPUT_APP_VERSION}/' ./bookstore*.tf"
               // sh "terraform init"
                // sh "terraform apply --auto-approve"
            }
        }
    }
}