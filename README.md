# Sanity

This is an application used to keep track of user's spending versus their budget.

## Contributors
    Tianmu Lei tianmule@usc.edu
    Ziqian Gu ziqiangu@usc.edu
    Jiaxin Cheng jiaxinch@usc.edu
    Ruyin Shao ruyinsha@usc.edu
    Yang Chen chen716@usc.edu
   
## Extra step for Sprint 1
   In Sprint 1, we implemented fingerprint login. In order to test this feature, the user should go to simulator Hardware->TouchID->Toggle Enrolled State to register a fingerprint.
   If the user want to use fingerprint to login, they should click Hardware -> TouchID -> Matching Touch for successfully login and Hardware -> TouchID -> Non-matching Touch for unsuccessful login. 
   
   The user can also click send summary to send a summary of budgets and transactions to the email the user registered. 
   
## 1 - Set up Server
  To run $anity server, one shall use the terminal(macOS) or command line(Linux or Windows) to connect to the digitalocean server first. Use command line: “ssh root@165.227.14.202” to connect to the online server, then the terminal shall ask for the password, type “chenyang” for the password to log into the server. Then one shall then type “java -jar server.jar” to run the server online. 
  ```
  ssh root@165.227.14.202
  java -jar server.jar
  ```
  If you need to see the code for server, please refer to https://github.com/jiaxinch/Sanity_Server_2

```
The server shall be started before the user attempt to open the client.
```

## 2 - Run application on local simulator
  1) Open Sanity.workspace in Xcode
  2) Run on platform iPhone 7 (default platform)
  ```
  NOTE: Please click allow for push notification access to gain notifications about budget overspent
  ```
  3) You should be directed to login page. If you don't have an account, create an account by clicking sign up.
  4) After you sign up or log in into the application, you should be directed to home page which consists of a list of budgets
  5) If you want to add a budget or a transaction, tap on add on the tap bar and click on add budget or transaction. (NOTE: You cannot add a transaction without having any budgets.)
  6) After you create a budget, you could see the budget list with the budget you created on home page.
  7) If you clicked your budget name, you will be redirected to a page that shows the percentage of your categories' amounts.
  8) Click 1 time on the pie of pie chat to see the detail
  9) Click 3 times to be redirected to single category page, which contains a pie chat that shows the amount you used and the amount that's left in that specific category. Right now you do not have any transactions related to the budget, the pie chart shall display 100% unused. Let's create one transaction to see what will happen.
  10) Go to Add -> Add Transaction -> Select your budget and category -> Add amount -> Submit
  11) You shall see a different pie chart display in single category display right now.
  12) If your total transaction exceeds limit * threshold. You should receive notifications from the app even outside the application.
  
