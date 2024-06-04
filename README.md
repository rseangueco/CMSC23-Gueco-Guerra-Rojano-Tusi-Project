# KalingApp (CMSC 23 Project)
## Group Members:
* Christian B. Rojano
* Tom Cristian R. Guerra

## Program Description
KalingApp is a mobile application that handles donations between donors and organizations.

Functionalities implemented for each user are specified below:
* Sign-Up
* Login/Logout
* Profile


**For donors:**
* Make a donation to an organization


**For organizations:**
* View donations
    - View donation details
    - Update status of donations
* Donation drives CRUD
* Link donations to donation drives


**For admins:**
* View organizations
* View donations
* View donors


## Installation Guide
To install the app, do the steps below:

1. Clone this repository to your local machine (See https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
2. Navigate to the root folder using your terminal
3. Type in the terminal `flutter build apk` 
4. The resulting apk would be inside the `..\CMSC23-Gueco-Guerra-Rojano-Tusi-Project\build\app\outputs\flutter-apk\app-release.apk` folder
5. Install this apk in your mobile device to use the application.


## How to use the App
1. Sign-up as donor/organization and fill out the needed fields as needed
2. Login
3. For each user:

**(a)** For donors:
1. In the homepage, select an organization that is open for donations to make donations to
2. Fill out the details needed for the donation
3. Confirm donation

**(b)** For organizations:
1. View donations and their status
    - Change status as needed
2. Select a donation drive
    - Create, edit, remove, view details as needed
3. Select "Link donations"
    - Link or unlink a donation by pressing the LINK/✔ button, respectively per donation item


