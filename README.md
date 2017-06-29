# box-comments
This program searches the content of a folder in Box.com (including all its sub-folders) and exports the name, ancestor folder and all comments of each file in a tab-delimited text file.

# Language
  Ruby

# Requirements

Requires Ruby 2.0.0 or higher.

For executions that would usually take less than 1 hour, the use of the developer token is enough to authenticate to the Box acount, However, for longer executions it is require OAUTH 2.0.

# Steps to gain OAUTH 2.0 authentication

First, access to the following URL from your website: 

https://account.box.com/api/oauth2/authorize?response_type=code&client_id=YOUR_CLIENT_ID&state=authenticated

Please remember to replace YOUR_CLIENT_ID with the client ID ooof your Box account.

You will need to authenticate to your Box account and then the URL will show an authorization code. You have 30 seconds to copy this code and then paste it in the next step.

The second step is to run from the command line or from Postman (Chrome extension) the following cURL command:

curl https://api.box.com/oauth2/token -d 'grant_type=authorization_code&code=YOUR_AUTHORIZATION_CODE&client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET' -X POST

Please remember to replace these values: <b>YOUR_AUTHORIZATION_CODE, YOUR_CLIENT_ID and YOUR_CLIENT_SECRET</b>.

<b>YOUR_AUTHORIZATION_CODE:</b> This one comes from the previous step.

<b>YOUR_CLIENT_ID:</b> Available accessing https://developer.box.com, creating a new app and copying this value from the configuration tab.

<b>YOUR_CLIENT_SECRET:</b> Available accessing https://developer.box.com, creating a new app and copying this value from the configuration tab.

# Additional information needed before executing this program
There are some initialization variables that you need to initialize with the right values. The code in this problem only includes sample values that you need to replace with real values from your Box account.

<b>totalRecords =</b> Total number of photos inside the ancestor folder in Box

<b>searchQuery =</b> Replace with search query

<b>fileExtension =</b> Replace this value with file type needed

<b>ownerUser =</b> Replace with the correct user ID

<b>ancestorFolder =</b> Id of the ancestor folder from where the search will run


