#!/usr/bin/env groovy

node {
    stage('Checkout') {
        checkout scm
    }
    stage('Packer checks') {
        sh './tests/packer'
    }
}
