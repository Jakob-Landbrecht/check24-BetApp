# CHECK24 GenDev Betting Challenge

## Table of Contents
- [Architectual Design desicions](#architectual-design-desicions)
     - [Backend](#backend)
          - [Deployment](#deployment)
          - [WebSocket](#websocket)
          - [Database](#database)
     - [Frontend](#frontend)
- [Features and Fullfilled Requirements](#features-and-fullfilled-requirements)
- [Testing](#testing)
- [Understanding the code](#understanding-the-code)
- [Demonstration](#demonstration)

## Architectual Design desicions
Before starting with the development of the application, there are numerous functional as well as non-functional requirements for the planned software. The most important in this case being the real-time capability in combination with handling over 10.000 online users and 2 million active participants. The european championship is a truely global event. Therefore, the frontend should be accessable to as many people as possible.  
### Backend
My first instinct was to a AWS DynamoDB instance paired with the Amazon API Gateway which also offers WebSocket capability and running other background tasks in AWS Lambda. Altough this would have been a suitable approach, ended up using Google cloud services.
#### Deployment
There are several aspects to consider when choosing a deployment option. A baremetal deployment would not make sense, as the tournament will result in distinct usage peaks that can not be probaply handelt by one machine. Eventhough, containers in combination with a microservice architecture could be used, I opted for a serverless architecture. More specifically I used Google cloud functions. These offer the benefit, that all scaling, shrinking and network management is handelt by Google, resulting in a very developer friendly and scalable experience. Considering the EM's timespan of one month, this is also a very budget friendly option, as one only pay's what one used. The cloud functions are used for tasks such as updating the ranking's in all communities, importing games, creating snapshots at midnight for visualizing deltas.
#### WebSocket
What is the best way to have 10.000 open Websocket connections? I spend hours researching this question. Even the Amazon API Gateway has a limitation of 500 new connections a minute, which could be easily reached durch the start of a game. The perfect solution for applications with many realtime clients directly requesting userdata is Firestore, which i will describe in more detail in the next chapter.
#### Database
Firestore is a product by Google as part of the Firebase offering. It offers specific SDK's for the predominant platforms that solve issues like offline data handling and make querying easy. Moreover it automatically scales so-called "subsciption Handler" services that notify the frontend of database changes (think of a scored goal). This way up to 1 million connections connections can be established. 
![changelog_architecture](https://github.com/Jakob-Landbrecht/check24-BetApp/assets/44413507/bd116719-d5b1-4310-83ab-489f64706b82)
### Frontend
## Features and Fullfilled Requirements
## Testing
## Understanding the code
## Demonstration




  

