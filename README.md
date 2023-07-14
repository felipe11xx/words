<p align="center">

  <h1 align="center">Words english Dictionary</h1>

  <p align="center">
    An english words dictionary 
    <br>
    This is a challenge by <a href="https://coodesh.com">
        Coodesh
  </p>
</p>

<p align="center">
  
  <h3 align="cente">BUILD WITH FLUTTER</h2>
  
  <a href="https://flutter.dev/">
    <img src="https://skillicons.dev/icons?i=flutter" />
  </a>
</p>

## Table of contents

- [Quick start](#quick-start)
- [What's included](#whats-included)
- [Frameworks](#frameworks)
- [Unit Tests](#unit-tests)
- [Creators](#creators)

## Quick start
* We Follow Clean arch and Solid Patterns to made this app.
* This is a normal flutter app. You should follow the instructions in the [official documentation](https://flutter.io/docs/get-started/install).
* Clone Project
* run `flutter doctor -v` check if there is no problem with Flutter and Dart on your machine
* run `flutter clean`
* run `flutter pub get`

* after installing and configuring the project.
    
  generate an API key on the <a href= "https://rapidapi.com/dpventures/api/wordsapi/pricing">WordsAPI</a> website and create a file called api_keys.dart in the directory `lib/shared/network`
  then in the file write the following code below 
  ```
  class ApiKeys{
  static const rapidApikey = 'Your_key';
  }
  ```


## What's included

* SignUp and signIn 
* A list off all english words
* User History feature
* User favorites words Features
* See a word with its meanings, pronunciation, spelling and phonetics
* Unit tests including code coverage


## Frameworks
  
<a href="https://firebase.google.com">
    <img src="https://skillicons.dev/icons?i=firebase" />
  </a>

* This repository is using Firebase. We use Firebase Auth and Realtime Database to control access and user registration and also save and access the list with all the words in the English language

  * firebase_core: ^2.1.1
  * firebase_database: ^10.2.3
  * firebase_auth: ^4.6.3
  * firebase_ui_database: ^1.3.3

 
<a href="https://github.com/hivedb/hive/tree/master/hive" > <img src="https://raw.githubusercontent.com/hivedb/hive/master/.github/logo_transparent.svg?sanitize=true" width="160"></a>

* This repo is Use Hive. We use hive to storage cache api, save user History and favorites on local 
  * hive: ^2.2.3
  * hive_flutter: ^1.1.0
  * path_provider: ^2.0.15


*  <a href="https://github.com/cfug/dio/tree/main/dio">Dio </a> This repo uses dio as powerful HTTP client for Dart/Flutter
   * dio: ^5.2.1+1
 
<a href="https://github.com/felangel/bloc/tree/master/packages/flutter_bloc" > <img src="https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/flutter_bloc_logo_full.png" width="160"></a>

* This Repo uses Flutter bloc as State manager that help to build and manager widgets and screens on app
   * flutter_bloc: ^8.1.3
     
<a href="https://github.com/Flutterando/modular">
<image src="https://raw.githubusercontent.com/Flutterando/modular/master/flutter_modular.png"  width="160">
</a>
  
* This Repo uses Flutter_modular to manage routes and binds of the project 
   * flutter_modular: ^5.0.3

* <a href="https://github.com/OpenFlutter/flutter_screenutil">flutter_screenutil</a> This repo uses flutter_screenutil a plugin for adapting screen and font size.Let your UI display a reasonable layout on different screen sizes!
  * flutter_screenutil: ^5.8.4

* <a href="https://github.com/spebbe/dartz">dartz</a> This repo uses Dartz to help on funcional programing and retriver data or error with Either class
   * dartz: ^0.10.1

* <a href="https://github.com/ixsans/text_to_speech">text_to_speech</a> This repo uses text_to_speech for the user to hear the words on the dictionary screen
  * text_to_speech: ^0.2.3

## Unit Tests
* Actual coverage of test are ![image](https://github.com/striker2x2/words/assets/6660920/cccb3abf-7e29-4bbf-baaa-415f71941541)


* All actual Tests are Pass ![image](https://github.com/striker2x2/words/assets/6660920/f6fb7bfd-63c4-43d4-955a-f945f6f2e209)

* don't wory more tests are coming soon :D

## Creators

**Felipe José Frazão**

- <https://github.com/striker2x2/>

Enjoy :metal:
