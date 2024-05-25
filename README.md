# CHECK24 GenDev Betting Challenge 🚀

## Table of Contents
- [Architectual Design desicions ⚽️](#architectual-design-desicions)
     - [Backend 🧮](#backend)
          - [Deployment :arrow_up:](#deployment)
          - [WebSocket :mailbox:](#websocket)
          - [Database 💽](#database)
     - [Frontend 🖥️](#frontend)
- [Features and fullfilled Requirements 💅](#features-and-fullfilled-requirements)
- [Understanding the code :test_tube:](#understanding-the-code)
- [Demonstration 🏆](#demonstration)
- [Conclusion](#conclusion)

## Architectual Design desicions
Before starting with the development of the application, there are numerous functional as well as non-functional requirements for the planned software. The most important in this case being the real-time capability in combination with handling over 10.000 online users and 2 million active participants. The european championship is a truely global event. Therefore, the frontend should be accessable to as many people as possible.  
### Backend
My first instinct was to use a AWS DynamoDB instance paired with the Amazon API Gateway which also offers WebSocket capability and running other background tasks in AWS Lambda. Altough this would have been a suitable approach, ended up using Google cloud services.
#### Deployment 
There are several aspects to consider when choosing a deployment option. A baremetal deployment would not make sense, as the tournament will result in distinct usage peaks that can not be probaply handelt by one machine. Eventhough, containers in combination with a microservice architecture could be used, I opted for a serverless architecture. More specifically I used Google cloud functions. These offer the benefit, that all scaling, shrinking and network management is handelt by Google, resulting in a very developer friendly and scalable experience. Considering the EM's timespan of one month, this is also a very budget friendly option, as one only pay's what one used. The cloud functions are used for tasks such as updating the ranking's in all communities, importing games, creating snapshots at midnight for visualizing deltas.
#### WebSocket
What is the best way to have 10.000 open Websocket connections? I spend hours researching this question. Even the Amazon API Gateway has a limitation of 500 new connections a minute, which could be easily reached durch the start of a game. The perfect solution for applications with many realtime clients directly requesting userdata is Firestore, which i will describe in more detail in the next chapter.
#### Database
Firestore is a product by Google as part of the Firebase offering. It offers specific SDK's for the predominant platforms that solve issues like offline data handling and makes querying data easy. Moreover it automatically scales so-called "subsciption Handler" services that notify the frontend of database changes (think of a scored goal). This way up to 1 million connections connections can be established. This makes near realtime Access to the leaderboard possible and is perfect for this application. One drawback I noticed are the limited options when building complex queries in contrast to SQL. Sadly queries kann only spann ower one collection (like a folder) which makes compounded requests very complicated and slow.
![changelog_architecture](https://github.com/Jakob-Landbrecht/check24-BetApp/assets/44413507/bd116719-d5b1-4310-83ab-489f64706b82)
### Frontend
The frontend is written in Flutter (or Dart to be precise). This cross-platform framework can be used to write Ios, Android and web applications from one code base. As this App is not tend to be completly production ready there are numerous aspects of my app, that still could be improved. First of all, there is currently no multi language support and some aspects of error handeling are not implemented. The app is structured in models (defining the data structure), screens (views), and services. **If you want check out and play around with the web version of my application on:** [bet.jakob-landbrecht.com](https://bet.jakob-landbrecht.com)  
Login/Tournament           |  Placing a Bet            |  Add/Join Community      |  Leaderboard             |
:-------------------------:|:-------------------------:|:-------------------------|:-------------------------|
<img src="https://github.com/Jakob-Landbrecht/check24-BetApp/assets/44413507/4f7353e5-bcd0-42e3-9a04-a7d8f1cc69b0" alt="drawing" width="220"/> | <img src="https://github.com/Jakob-Landbrecht/check24-BetApp/assets/44413507/08f78751-94f5-4c2a-b540-bff4cb9a3aab" alt="drawing" width="220"/> | <img src="https://github.com/Jakob-Landbrecht/check24-BetApp/assets/44413507/bf81f015-e898-4ec1-b030-892ed130241e" alt="drawing" width="220"/> | <img src="https://github.com/Jakob-Landbrecht/check24-BetApp/assets/44413507/b896ddd8-dbac-4d20-9690-b610dd312a08" alt="drawing" width="220"/>


## Features and Fullfilled Requirements
1. Authentication: Firebase Authentication is used to authenticate the user. This way other authentication providers such as Google, Apple or Facebook could be easily added.
2. Communities: The app can handle multiple tournaments simultaniously and the app can switch between the different tournaments. Every user can create (or join) tournaments and send an invitation code to his friends.
3. Leaderboards: The leaderboard provides the option to search for a specific user and to filter. The total delay from changing the score count until to the reordering of the scores on the client device is typically below 2 seconds
4. Betting: Betting is simple. On the Dashboard you can always see the upcoming games including other useful information (For this I wrote a cloud function that parses a publically available JSON with all games and creates the database entries automatically. Furthermore I host all country flags of the world on a Cloud storage bucket, to show the country flags). From there one can easilly create a bet.
5. Real-time updates: The total delay is under 2 seconds. Cloud Functions sometimes suffer from "cold starting" problems if they are not invoked enough. After the first initial invocation the delay sinks close to one second, which is not really noticable to the user. As a future improvement one could build an admin UI to change to scores more easily. The current process involves to change the entry in the provided Firebase website.
6. Dashboard: The dashboard shows the current life game and the next upcoming game. Additionally it shows the required previews of the communities the player is part of.
7. Pinning friends: Pinned friends are **not** stored in the cloud but via a plugin called "shared_preferences" which handles to offline storing for the different operating systems.
## Understanding the code
There are two important folders. The first one is [functions](https://github.com/Jakob-Landbrecht/check24-BetApp/tree/main/functions) that stores all serverless functions deployed to Google. The second one is [lib](https://github.com/Jakob-Landbrecht/check24-BetApp/tree/main/betapp/lib) which holds all frontend related files.
## Demonstration
1. Take a look at this guided demonstration, presenting the Ios version: [Youtube](amazon.de)  
2. Play around with the web version yourseld: [bet.jakob-landbrecht.com](https://bet.jakob-landbrecht.com)
You can adjust the score of the upcoming game by invoking this url:
```
https://helloworld-csjycr6t2q-uc.a.run.app
```
## Conclusion
I invested a long time in this project and in retrospect there are multiple issues I would like to improve on. Firstly, the overall structuredness of the code. I did not stick to the correct variable notation recommended by dart and opted for camelcase. This also results in an inconsistend nameingconvetion for the names of some entries in the database. Secondly, decoupling. Eventhough, my project is fairly well structured, I would now create a unique cloud Function for every single database request (except the ones requiering realtime upadtes). This would make it easier to replace the Database and to handle incorrect requests.  
If you have any questions regarding my project, feel free to contact me: [jakob.landbrecht@gmail.com](jakob.landbrecht@gmail.com)  
I would be very pleased to receive positive feedback. (You can of course also awnser me in German)
  

