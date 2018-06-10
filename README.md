# EmployeeManagementApp
This application is a Master Detail Application that uses the Alamfire and SwiftyJSON pods to Read,Create, and Delete Employees stored on a Server. You need Xcode 9.2 to open everything as a workspace. Otherwise, open the files individually and make a new project.


# Requirements
- Node: https://nodejs.org/en/
- (Optional) Sublime Text: https://www.sublimetext.com/
- Alamofire: https://github.com/Alamofire/Alamofire
- SwiftyJSON: https://github.com/SwiftyJSON/SwiftyJSON

# Instructions
Note: These instructions assume you have gems installed on your Mac already

1. Clone the repo
2. Open Terminal 
3. Navigate to the folder where you cloned the repo
4. pod install if the pods don't work, but they should

if there is a heroku-app server available, simply change the URLs in the Alamofire requests
to the proper URLs

for local server use:

5. Clone the EMALocalServer repo
6. Once downloaded, open Terminal
7. navigate to the folder where the server files are located
8. npm install 
9. npm start

10. The server will run, and you can use the app

