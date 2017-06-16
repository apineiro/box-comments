# This program searches of the content of a folder in Box.com and all its sub-folders and
# exports the name, ancestor folder and all comments of each file in a tab-delimited text file.

#Loads Ruby client library for the Box V2 Content API.
require 'boxr'

#Initializing variables to run the search query through a loop and increasing variables  based on limits of offset and limit parameters
offset =  0
limit = 200
totalRecords = 1026
recordCount = 0
searchQuery = "*.jpg" #replace with search query
scope = ["user_content"]
fileExtension = ["jpg"] #replace with file type needed
ownerUser = ["12637368"]
ancestorFolder = ["12566643253"]
fileType = ["file"]
fieldId = ["id"]

#Creates a Boxr client with the use a Box Developer Token (generated from Box app's General Information page)
#The Box developer Token is valid for 60 minutes
client = Boxr::Client.new('TnEITiBXsRjsGAT0DmxSaJOXu0uXu2Op')

## While loop to search all jpf files within the ancestor folder and increase limit every 200 records
while offset <= totalRecords do
  ## This section performs the initial search of all jpg files in ancestorFolder (using the folder id) folder in Box
  results = client.search(query= searchQuery, scope: scope, file_extensions: fileExtension,
          owner_user_ids: ownerUser, ancestor_folder_ids: ancestorFolder, type: fileType,
          offset: offset, limit: limit)
  ##Ruby "require" method to use csv
  require 'csv'
  #Opens the csv file "records.csv" as write and tab-delimited columns
  CSV.open("records.txt", "w", { :col_sep => "\t" }) do |csv|
    #Loop that reads all file IDs
    results.each do |fileId|
      #Assignes fileId to the variable number_id as integer instead of string
      number_id = fileId.id
      #Queries the next file
      file = client.file(number_id)

      recordCount += 1
      p recordCount

      #Displays on screen the name of the file
      p file.name
      #Displays on screen the name of the parent folder of the file
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
  end #Closes the loop that opened the text file "records.csv" and closes the file
  offset += 200
end #Closes the outer While loop
