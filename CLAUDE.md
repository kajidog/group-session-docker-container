# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Build and Deploy
```bash
# Build the Docker image
docker-compose build

# Start GroupSession container
docker-compose up -d

# Check container status
docker-compose ps

# View logs
docker-compose logs -f groupsession

# Stop container
docker-compose down
```

### Development Workflow
1. Place the GroupSession WAR file as `gsession.war` in the root directory (download from https://groupsession.jp/)
2. Modify configurations in `docker-compose.yml` or `Dockerfile` as needed
3. Rebuild the image after changes: `docker-compose build`
4. Restart the container: `docker-compose restart`

## Architecture

### Container Configuration
- **Base Image**: Uses `tomcat:9-jdk11-temurin` (Eclipse Adoptium)
- **Java Environment**: Temurin JDK 11 with Tomcat 9
- **Japanese Localization**: Configured with `ja_JP.UTF-8` locale and `Asia/Tokyo` timezone
- **Memory Settings**: Default JVM heap size is 2GB max / 1GB initial (configurable in docker-compose.yml)
- **Startup Process**: Uses custom startup script that waits for deployment before applying configuration

### Key Components
1. **Dockerfile**: Defines the container image with Japanese localization settings
2. **docker-compose.yml**: Orchestrates the container with volume mounts and environment variables
3. **startup.sh**: Startup script that waits for GroupSession to be ready and copies configuration
4. **gsdata.conf**: GroupSession data directory configuration mapping to `/home/gsession/`

### Data Persistence
- GroupSession data is persisted in `./gsession_data` directory (mounted as `/home/gsession` in container)
- Configuration is copied from `/tmp/gsdata.conf` to the webapp directory on startup

### Access Points
- Web Interface: http://localhost:8080/gsession/
- Default credentials: admin / admin

## Important Notes
- The WAR file must be manually downloaded from the official GroupSession website
- Container startup takes approximately 20 seconds for full initialization
- The `startup.sh` script ensures GroupSession is fully deployed before applying configurations
- Default login credentials: admin / admin

## Troubleshooting
- **Container restart loops**: Check logs with `docker-compose logs groupsession` - usually indicates startup script issues
- **Port conflicts**: Ensure port 8080 is available on the host system
- **Memory issues**: Adjust `JAVA_OPTS` in docker-compose.yml for OutOfMemory errors
- **Locale warnings**: Locale warnings in logs are harmless and don't affect functionality