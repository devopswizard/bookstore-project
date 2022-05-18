pipeline {

    agent any

    stages {

        stage("Interactive Input") {
            steps {
                script {

                    // Variables for input
                    def inputServer
                    def inputAppVersion

                    // Get the input
                    def userInput = input(
                            id: 'userInput', message: 'Enter path of test reports:?',
                            parameters: [
                                [$class: 'ChoiceParameterDefinition',
                    choices: ['Ubuntu_18_04','Amazon_Linux_2'].join('\n'),
                    name: 'Server',
                    description: 'Select the Operating System'],
                                [$class: 'ChoiceParameterDefinition',
                    choices: ['v1','v2'.join('\n'),
                    name: 'AppVersion',
                    description: 'Select Your App Version']
                            ])

                    // Save to variables. Default to empty string if not found.
                    inputServer = userInput.Server?:''
                    inputAppVersion = userInput.AppVersion?:''

                    // Echo to console
                    echo("Selected Server: ${inputServer}")
                    echo("Selected Version: ${inputAppVersion}")
                }
            }
        }
        stage("Create Server and App") {
            steps {
                echo 'Creating Prod Server via Terraform...'
                sh "cd ./${inputServer}"
                sh "sed -i 's/branchX/${inputAppVersion}/' ./bookstore*.tf"
                sh "terraform init"
                sh "terraform apply --auto-approve"
            }
        }
    }
}