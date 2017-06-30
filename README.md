# box-comments
This program searches the content of a folder in Box.com (including all its sub-folders) and exports the name, ancestor folder and all comments of each file in a tab-delimited text file.

## Language
  Ruby

## Requirements

Requires Ruby 2.0.0 or higher.

For executions that would usually take less than 1 hour, the use of the developer token is enough to authenticate with the Box account, However, for longer executions OAUTH 2.0 it is require.

## Steps to gain OAUTH 2.0 authentication

1. First, access the following URL from your browser: 

```
https://account.box.com/api/oauth2/authorize?response_type=code&client_id=YOUR_CLIENT_ID&state=authenticated
```

Please remember to replace YOUR_CLIENT_ID with the client ID of your own Box account.

You will need to authenticate with your Box account and then the URL will show an authorization code. You have 30 seconds to use this code in the next step.

2. The second step is to run -from the command line or from Postman (Chrome extension)- the following cURL command:

```
curl https://api.box.com/oauth2/token -d 'grant_type=authorization_code&code=YOUR_AUTHORIZATION_CODE&client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET' -X POST
```

Please remember to replace these values: YOUR_AUTHORIZATION_CODE, YOUR_CLIENT_ID and YOUR_CLIENT_SECRET.

**YOUR_AUTHORIZATION_CODE:** This one comes from the previous step.

**YOUR_CLIENT_ID:** Available accessing https://developer.box.com, creating a new app and copying this value from the configuration tab.

**YOUR_CLIENT_SECRET:** Available accessing https://developer.box.com, creating a new app and copying this value from the configuration tab.

## Additional information before using this program

There are some initialization variables that you need to set with the right values. This code only include sample values and you need to replace them with real values from your Box account.

**1. totalRecords =** Total number of files in the ancestor folder in Box. You can use Postman to get this number

**2. searchQuery =** Replace this value with the desired search query

**3. fileExtension =** Replace this value with the file type needed

**4. ownerUser =** Replace with the correct user ID

**5. ancestorFolder =** Id of the ancestor folder from where the search will run (the query will include the content of all sub-folders.


