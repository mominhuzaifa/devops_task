pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/kabirbaidhya/react-todo-app.git'
        DEPLOY_DIR = '/opt/deployment/react'
        CHECKOUT_DIR = '/opt/checkout/react-todo-app'
      //  CHECKOUT_DIR_NEW = '/opt/checkout/react-todo-app'
    }

    stages {
        stage('Stop Deployment') {
            steps {
                script {
                    
                    sh "pm2 stop all"
                   
                }
            }
        }

        stage('Remove exisiting code'){
            steps{
                script{
                    sh 'rm -rf /opt/checkout/react-todo-app'
                    
                }
            }
        }

        stage('Pull Fresh Code from Git') {
            steps {
                script {
                    // Pull fresh code from Git
                   sh "git clone ${GIT_REPO} ${CHECKOUT_DIR}"
                   
                }
            }
        }

        stage('Build React App') {
            steps {
                script {
                    // Build your React app
                    sh "cd ${CHECKOUT_DIR} && npm install && npm run build"
                    
                }
            }
        }

        stage('Deploy using PM2') {
            steps {
                script {
                    // Deploy using PM2
                    sh "pm2 start ${CHECKOUT_DIR}/src/index.js"
                }
            }
        }

        stage('Upload to S3') {
        steps {
            script {
                
                //Use the S3 plugin to upload files
                s3Upload(
                    site: 'arn:aws:s3:::viamagus',
                    region: 'ap-south-1',
                    bucket: 'viamagus',
                    filesPath: "${CHECKOUT_DIR}",
                    flatten: true,
                    endpoint: 's3.amazonaws.com',
                    acl: 'PublicRead',
                    otherProperties: '{"Cache-Control": "max-age=31536000, public"}'
                    )
                }
            }
        }
    }
}
