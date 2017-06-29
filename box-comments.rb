# This program searches of the content of a folder in Box.com and all its sub-folders and
# exports the name, ancestor folder and all comments of each file in a tab-delimited text file.

#Loads Ruby client library for the Box V2 Content API.
require 'boxr'
##Ruby "require" method to use csv
require 'csv'

#Initializing variables to run the search query through a loop and increasing variables  based on limits of offset and limit parameters
offset =  0
limit = 200
totalRecords = 28000 #Current number is just an example). Total number of photos inside the ancestor folder in Box
recordCount = 1 #Starting with first record or photo
searchQuery = "*.jpg" #replace with search query
scope = ["user_content"]
fileExtension = ["jpg"] #replace with file type needed
ownerUser = ["27637337"] #This is just an example
ancestorFolder = ["322822423"] #This is an example. id of the ancestor folder from where the search will run
fileType = ["file"]
fieldId = ["id"]

#Creates a Boxr client with the use a Box Developer Token (generated from Box app's General Information page)
#The Box developer Token is valid for 60 minutes
client = Boxr::Client.new('YOUR_ACCESS_TOKEN_HERE',
                          refresh_token: 'YOUR_REFRESH_TOKEN_HERE',
                          client_id: 'YOUR_CLIENT_ID_HERE',
                          client_secret: 'YOUR_CLIENT_SECRET_HERE',)

#Opens the csv file "records.csv" as write and tab-delimited columns
CSV.open("records.txt", "w", { :col_sep => "\t" }) do |csv|
  ## While loop to search all jpf files within the ancestor folder and increase limit every 200 records
  while recordCount <= totalRecords do
    ## This section performs the initial search of all jpg files in ancestorFolder (using the folder id) folder in Box
    results = client.search(query= searchQuery, scope: scope, file_extensions: fileExtension,
          owner_user_ids: ownerUser, ancestor_folder_ids: ancestorFolder, type: fileType,
          offset: offset, limit: limit)
    #Loop that reads all file IDs
    results.each do |fileId|
      #Assignes fileId to the variable number_id as integer instead of string
      number_id = fileId.id
      #Queries the next file
      file = client.file(number_id)
      # Display record counter on screen as reference during execution
      p recordCount
      #Record counter icrease
      recordCount += 1
      #Displays on screen the name of the file as reference during execution
      p file.name
      #Displays on screen the name of the parent folder of the file during execution
      p file.parent.name

      #Queries the comments of the file
      comments = client.file_comments(number_id)
      #Loop that searches every comment of the file
      comments.each do |comment|
        commentaries = comment.message
        #Replaces special character such as \n (new line), \r (carriage return) with spaces
        commentaries = comment.message.gsub(/[\n\r]/, " ")
        #Displays on the screen the next commentary found for the current file
        p commentaries
        #Stores the file name, parent folder and commentaries of each file in text file "records.txt"
        csv << [file.name,file.parent.name,commentaries]
      end #Close the loop for searching each commentary
    end #Closes the loop for searching each file
    #Increase offset by 200 to countinue query of next 200 records
    offset += 200
  end #Closes the outer while loop
end #Closes the text file "records.csv"
