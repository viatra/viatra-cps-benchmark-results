// Tell Jenkins how to build projects from this repository
pipeline {
  agent {
    label 'iqlabs-performance'
  }

  parameters {
    choice(choices: 'm2m-reduced\nm2m-lowsynch\nm2m\ntoolchain\ndred-perf-regression\ndred-perf-regression-lowsynch', description: 'Select the benchmark configuration to process', name: 'BENCHMARK_CONFIG')
    string(defaultValue: 'latest', description: 'ID of results (folder name) to process.', name: 'RESULT_ID')
  }

  stages {

    stage('Update MONDO-SAM') {
      steps {
        sshagent(['24f0908d-7662-4e93-80cc-1143b7f92ff1']) {
          sh "./scripts/dep-mondo-sam.sh"
        }
      }
    }

    stage('Report') {
      steps {
        sh "./scripts/report.sh ${params.BENCHMARK_CONFIG} ${params.RESULT_ID}}"
      }
    }

  }

}
