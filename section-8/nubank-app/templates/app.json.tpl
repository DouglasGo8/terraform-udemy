[
  {
    "essential": true,
    "memory": 256,
    "name": "nubank-app",
    "cpu": 10,
    "image": "${REPOSITORY_URL}:latest", 
    "entryPoint": [
      "java",
      "-jar",
      "nubank-check-balance-app-1.0-SNAPSHOT-fat.jar"
    ],
    "portMappings": [
        {
            "containerPort": 32666,
            "hostPort": 32666
        }
    ]
  }
]