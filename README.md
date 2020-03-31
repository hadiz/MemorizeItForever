# MemorizeItForever
## Download the app

Please download the app from [this link.](https://itunes.apple.com/us/app/memorizeitforever/id1352050968?ls=1&mt=8)

## Description

MemorizeItForever helps people to learn and memorize new words, phrases, formulas, etc..
It works based on the Leitner system. 

It contains two subprojects:

* **MemorizeItForeverCore**

  MemorizeItForeverCore has the business rules and communicates with the database via the BaseLocalDataAccess library. Models also are defined there.

* **MemorizeItForever**

  MemorizeItForever is an iOS app that uses MemorizeItForeverCore to get the appropriate data and save it correctly.
 
 
 Both projects are using Swinject to handle the dependency injection.
