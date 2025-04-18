# Use the official Jetty base image with JDK 8
FROM jetty:9.4-jdk8

# Set the working directory to Jetty's webapps directory
WORKDIR /var/lib/jetty/webapps

# Copy the WAR file into the webapps directory and rename it to ROOT.war
COPY /var/lib/jenkins/workspace/java-app-pipeline_main/target/my-webapp.war ROOT.war

# Ensure the WAR file has appropriate permissions
RUN chmod a+r ROOT.war

# Expose Jetty's default port
EXPOSE 9090

