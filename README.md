
<img src="https://i.imgur.com/qwJ87ei.png" width="250" height="250">

### MovieFinder Project

A small web application for browsing movies or exploring random ones.
<img src="https://i.imgur.com/ooUSzTy.jpeg" width="500" height="400">
## Getting Started
This basic application is based on Vue 3 and uses the Quasar UI Framework.
It follows the basic structure of the Quasar Framework and is easy to understand.
The data used is from the https://themoviedb.org API.

I developed this as a university project, and at that time, I preferred using the German language for 
the backend data as well as the UI components.

If you'd like to improve the existing project, feel free to change the movie data and UI components to
your preferred language for data fetching.

### Features
* The index page displays the latest movies added to the themoviedb.org API.
* The search functionality on the Index Page forwards users to the Result Page with search results.
* The Detail Section pops up when 'More Info' is clicked, showing the movie description, genres, review count, and the star rating. (Note: Only the count of reviews is shown, not the reviews themselves.)
* The Result Page displays the specific movies as mentioned above.

### How to Install?
You have two options to install and run the project:
## Option 1: Local Run

First, clone the project to your target directory.
Switch to the root directory of the project and ensure you can use npm with your terminal or command prompt.

Then execute:
```
npm install
```
This command installs the project dependencies. 

After that, you should be able to run the project locally by executing:
```
npm run dev
```

## Option 2: Docker

I have compiled everything you need to run the project as a developer in the 'Dockerfile'.

Initially, switch to the project root (where the Dockerfile is located), and run the following command:
```
docker build . -f Dockerfile -t moviefinder
```

Next, run the built image:
```
docker run moviefinder
```

That's it! The project should now be running in your Docker container.
