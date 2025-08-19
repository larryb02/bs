#Proof of concept build server for C programs

# Architecture
###  API
REST API that exposes an interface for a client to communicate with the build server system  

Built using FastAPI framework

For api documentation visit [here](./openapi.json) this file can be viewed on a swagger editor
###  Build Agent
Long running task that manages jobs and workers  

The build agent maintains a job queue and assigns workers to jobs  
Improvements that could be made are: 
- Creating an abstraction to allow dynamic creation of job queues in order to better scale when a new feature arises and to separate code that workers should execute from the agent
- Dynamically creating workers up to config specified limits to allow for more throughput
###  Builder
API for building C programs  
This gets called by workers in the build agent
### Rebuilder
Long running task that checks for new commits for any builds known to the server
### Artifact Repository
The artifact repository is a structured directory that stores artifacts with the following pattern: <commit_hash>/artifact  

The code that provides functionality to interact with the artifact repository can be found in artifactstore.py  

Ideally the artifact repository should be able to exist locally, on a file server, or on a cloud based object store such as Amazon S3, however this is a WIP
###  Database
Postgresql Server  
Tables:
- Artifact
    - Stores metadata about artifacts such as the artifacts path in the artifact repository
- Build
    - Stores metadata about builds such as the build status, the repository url, and the commit hash

### Web App
Web interface to view builds known to the system and their status

The entry point of this application resides in /api/main.py this is where the http server, the build agent, and the rebuilder are configured and initialized

### Kicking off builds
In order to register repositories for builds, there is an endpoint exposed via REST api  
```bash
curl -X POST http://localhost:8000/builds/register \
  -H "Content-Type: application/json" \
  -d '{"git_repository_url": "value"}'
``` BS
