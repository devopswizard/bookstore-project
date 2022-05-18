pipeline {

    agent any

    stages {

        stage("Interactive_Input") {
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
                    choices: ['Ubuntu 18.04','Amazon Linux-2', 'Debian', "Windows Server 2019"].join('\n'),
                    name: 'Server',
                    description: 'Select the Operating System'],
                                [$class: 'ChoiceParameterDefinition',
                    choices: ['v1','v2', 'v3', "v4"].join('\n'),
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
    }
}