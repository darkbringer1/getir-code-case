# Shopping App Project
This project developed by Dogukaan Kilicarslan

###### Tools used to develop this project:
- Xcode Version 13.4.1 
- Tested in iOS 15.5 simulator and 15.6.1 iPhone 6s Plus real device

## Get Started
The purpose of this project is to get various market items from a mock api and generate a template for a simple shopping app. UIKit and self made network package are preferred to develop this app.

Closures were heavily taken advantage of in this project but protocols are also used in different components.

### Architecture 
MVVM-C pattern is used in this project. Focused on component based development with the protocol oriented programming to make the code cleaner and scalable.

- Factory pattern is used to initializing in proper way.
- Protocol oriented programming and dependency injections are used.
- Prevented using singletons as much as possible.
- View classes are abstracted from the view controllers to make it cleaner and reusable.

### Network Layer

Since service calls do not require any authorization and there is only one service endpoint, a simple network layer constructed and added to project as a local Swift Package. 

I wanted to keep my network flow as linear as it's possible to make it suitable for SOLID's dependency inversion. High level objects shouldn't rely on the lower level objects.

### Coordinator Layer

This is a relatively small app with limited views. Coordinator layer was only constructed in HomeView since it is the root view controller and every view we want to reach we can use the HomeView's coordinator. 

Furthermore an AppCoordinator could be added to further scalability and ease of navigation but for a small app it was not necessary. 

### UI decisions

Programmatic UI is preferred in this project to get more control over the UI components, lower the build time, keep the UI manipulation codes in one place and most importantly for ease of code review.

Every page in the app uses its own component files since there was no mutual components. Altough UI components could be dissected further and used independently but in its current state every component can be easily edited to make them reusable in different sections of the app.

### Data operations

CoreData was used to persist the downloaded items. When an item is updated it is also updated in CoreData layer then displayed in BasketView according to their counts. All items are used from CoreData layer to lower the internet connection dependency. 

A network checker layer is developed to check if the internet connection is present. When internet connection is established, app tries to download and set the items to the CoreData layer. If internet connection is lost, app tries to get the items from CoreData layer. 

### Summary

Overall, it was an excellent experience to have a chance to use CoreData this heavily. I always wanted to use CoreData but I never had the chance or need to use it. 

Although UI is not very complex, updating the UI with most interactions user makes was very challenging and there are still improvements that could be made in the project. 
