pipeline {
    agent any

    stages {
        stage('Ansible Test') {
            steps {
                echo 'check version Ansible'
                sh 'ansible --version'
            }
        }
        stage('Test Ping') {
            steps {
                echo 'test ping Localhost'
                sh 'ansible -m ping localhost'
            }
        }
    }
}
