# Use an official node runtime as a parent image
FROM node:14

# Set the working directory in the container to /frontend
WORKDIR /frontend

# Copy package.json and package-lock.json into the container at /frontend
COPY package*.json ./

# Install any needed packages
RUN npm install

# Bundle app source
COPY . .

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Start app
CMD ["npm", "start"]
