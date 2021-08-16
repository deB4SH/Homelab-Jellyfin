pipeline{
    //global agent - its just an maven jar
    agent {
        kubernetes {
            containerTemplate {
                name 'maven'
                image 'jeekajoo/maven-dind:latest'
                command 'sleep'
                args 'infinity'
            }
            defaultContainer 'maven'
        }
    }
    //options
    options{
            disableConcurrentBuilds()
            buildDiscarder(logRotator(numToKeepStr: '5'))
            disableResume()
            timeout(time: 2, unit: 'HOURS')
    }
    //define trigger
    triggers{
        pollSCM 'H/30 * * * *'
    }
    //stages to build and deploy
    stages {
        stage ('check: prepare') {
            steps {
                sh '''
                    mvn -version
                    export MAVEN_OPTS="-Xmx1024m"
                '''
            }
        }
        stage ('build: setVersion') {
            when {
                branch 'release/*'
            }
            environment {
                BRANCHVERSION = sh(
                    script: "echo ${env.BRANCH_NAME} | sed -E 's/release\\/([0-9a-zA-Z.\\-]+)/\\1/'",
                    returnStdout: true
                ).trim()
            }
            steps {
                echo 'Setting release version'
                echo "${BRANCHVERSION}"
                sh 'mvn versions:set -DnewVersion=${BRANCHVERSION} -f ./pom.xml'
            }
        }
        stage('build') {
            steps {
                //settings_xml required to access github registry
                withCredentials([file(credentialsId: 'settings_xml', variable: 'settings')]) {
                   writeFile file: '.settings/.m2_settings.xml', text: readFile(settings)
                }
                sh 'mvn clean package -s .settings/.m2_settings.xml -f pom.xml'
            }
            post {
                always {
                    junit 'target/reports/*.xml'
                }
            }
        }
        stage ('deploy: whenRelease') {
            when {
                branch 'release/*'
            }
            steps {
                sh 'mvn deploy -s .settings/.m2_settings.xml -f pom.xml'
            }
        }
    }

}
