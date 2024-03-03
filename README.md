# tasky

Easiest way to list your tasks!

## Introduction
This project is built to fulfill the assignment of RISTEK Open Recruitment 2024 for Mobile Development SIG.

## Lesson Learned
Througout the development process, I got a lot of new insight about Flutter. The Flutter documentation website (https://docs.flutter.dev/) was really a big help for me. I look at it back and forth to learn some concept and widget implementation. For me, Sliver widget is a really cool widget that I implemented in this project. It makes scrolling so fun. 

In this project, I also implement local storage using Hive (https://pub.dev/packages/hive/) for getting persistent data. It is quite challenging at first, especially when making the adapter to my model. But I could manage that. 

Oh ya, in this project, I implement (sort of) an architecture pattern that separate the concerns between UI, business logic, and data management. I don't really sure what architecture I'm using. It's like mixed of MVC, MVVM or Clean Architecture, perhaps. I use models folder for the data definition, repositories for data management, services for business logic, and pages & widget for UI presentation. Additionally, I use get_it package (https://pub.dev/packages/get_it) to handle the dependencies between those layers. Also, I try to implement SOLID Principle. One implementation of it is making such layer dependent to abstract object/interface in other layer, such as service-repository.