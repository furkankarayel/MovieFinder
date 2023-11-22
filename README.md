
<img src="https://i.imgur.com/qwJ87ei.png" width="250" height="250">

https://i.imgur.com/ooUSzTy.jpeg

# MovieFinder Project

A small web application for browsing Movies or just explore random ones.

## Getting started
This is a basic application based on Vue 3 using Quasar UI Framework.
It uses the basic structure of Quasar Framework and is easy to understand.
The data I am using is from https://themoviedb.org API.

I have developed it as an university project so back then I prefered the german language for 
the backend data aswell as the UI components which have been used.

If you'd like to improve the existing project, feel free to change the movie data and ui components to
your own language where the data gets fetched.

### Features
* Index page which is displaying the latest movies added to themoviedb.org API.
* Search functionality is working on the Index Page, which forwards users to the Result Page with the search results.
* Detail Section is popping up when clicked on 'More Info' containing the description of the movie, genres, review count and lastly the star rating. (The reviews are not shown, it shows only the count)
* Result page displays the specific movies as mentioned above.


### How to install?
You have two options to install and run the project:
## Option 1: Local run

First of all you need to clone the project to your target directory.
Switch into the root dir of the project and make sure you are able to use
npm with your terminal or cmd.

Then execute:
```
npm install
```
By the first command you install the project dependencies. 

After you have done that you should be able to run the project locally by executing:
```
npm run dev
```

## Option 2: Docker

I have put together everything you need to run the project as developer in the docker container.

First of all we need to switch into the project root(where the Dockerfile lies), and run the following command:
```
docker build . -f Dockerfile -t moviefinder
```

Now we need to run the image which has been built.
Run:
```
docker run moviefinder
```

Yeah! Now the project should be running in your Docker container..