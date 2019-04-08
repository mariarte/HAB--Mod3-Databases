(1) Create Database
Use db_name will create a database if it doesn’t exist. You can drop the database with dropDatabase().
use usermanaged
# to drop database
db.dropDatabase()
(2) Create a Collection & Insert a Record
It really doesn’t matter if you put double quote or not. Either format works.
use usermanaged
db.customers.insert( 
        { "firstName":"John", 
          "lastName":"West", 
          "email":"john.west@mail.com", 
          "phone":"032345432134",
          "BusinessType": ["Sell", "Sugar", "Drinks"],
          "Reference":100,
          "Company":"Coca-Cola"})

# This works, too.
db.customers.insert( 
        { firstName:'John', 
          lastName:'West', 
          email:'john.west@mail.com', 
          phone:'032345432134',
          BusinessType: ['Sell', 'Sugar', 'Drinks'],
          Reference:100,
          Company:'Coca-Cola'}) 

# You can drop it like this
db.customers.drop()
(3) Bulk Load JSON File
You can import data from json, csv or tsv files with mongoimport and export data with mongoexport. Note that these are not for backups as you loose some data type information by writing it to flat files.
You need to quit the Mongo Shell session and use Terminal.
For multiple records, you need jsonArray option. Otherwise you get the error message below.
Failed: error unmarshaling bytes on document #0: JSON decoder out of sync – data changing underfoot?
# 1: Drop the collection if exists and then recreate the new one before importing.
mongoimport --db usermanaged --jsonArray --collection transactions --drop --file C:\tmp\transaction.json
# 2: Append to the exisiting collection
mongoimport --db usermanaged --jsonArray --collection transactions --mode insert --file C:\tmp\transaction.json
# 3: Upsert from the file
mongoimport --db usermanaged --jsonArray --collection transactions --mode upsert --upsertFields Id --file  C:\tmp\transaction_upsert.json
Once imported, you can log into the database and check the data.
mongo
db.transactions.count()
db.transactions.find().pretty()
(4) Bulk Load CSV File
Keys will be created from the header row. –headerline and –type csv are required. You can use whatever csv available.
mongoimport --db usermanaged --collection online_news_popularity --type csv --headerline --file C:\tmp\OnlineNewsPopularity.csv
(5) Query MongoDB with Conditions
# 1. Find a record in transactions where name is tom
db.transactions.find({Name: 'Tom'})

# 2. Find a record in transactions where total payment amount is 400.
# When chaining key with dot, you need doublequote.
db.transactions.find({"Payment.Total": 400 })
db.transactions.find({"Payment.Total": {$eq: 400}})

# 3. Find a record in transactions collection where price is greater than 400
db.transactions.find({"Transaction.price": {$gt: 400} })
# can do equal or greater than, too.
db.transactions.find({"Transaction.price": {$gte: 400} })

# 4. Find a record in transacaions collection where note is null or missing
db.transactions.find({"Note": null})

# 5. Find a record where only Note key is missing
db.transactions.find({Note: {$exists: false } })

#6. Null only
db.transactions.find({Note: {$type: 10 } })
(6) Aggregation with MongoDB
# 1. Calculate the total transaction amount by aggregating Payment.Total in all records
db.transactions.aggregate({
    $group: {
        _id: '',
        TotalRevenue: { $sum: '$Payment.Total' }
    }
 })

# 2. Aggregate per record by aggregating Transaction.price
db.transactions.aggregate([
   {
     $project: {
       revenueTotal: { $sum: "$Transaction.price"},
     }
   }
])

# 3. Aggregate per payment type by adding up Payment.Total
db.transactions.aggregate([
     {
       $group:
         {
          _id: "$Payment.Type",
           totalAmount: { $sum: "$Payment.Total" },
           count: { $sum: 1 }
         }
     }
])


# 4. Find the max id 
db.transactions.aggregate([
    {
        $group:
        {
            _id: '',
            maxId: {$max: "$Id"}
        }
    }
])

# 5. Find the max Transaction.price
# Transaction.price is an array. So find the array containing maximum price and then extract
# the max price from the array with another $max.
db.transactions.aggregate([
    {
        $group:
        {
            _id: '',
            maxPrice: {$max: {$max: "$Transaction.price"}}
        }
    }
])
 (7) CRUD Operations
# 1. Inserting a record into transaction
db.transactions.insert(
    {
    "Id": 110,
    "Name": "Inserted Record",
    "TransactionId": "tranNew1",
  "Transaction": [
    {
    "ItemId":"c324",
    "price": 456
    },
    {
    "ItemId":"d456",
    "price": 543   
    }
  ],
  "Subscriber": false,
  "Payment": {
    "Type": "Debit-Card",
    "Total": 999,
    "Success": true
  },
  "Note":'Hello World'
})

# check the record
db.transactions.find({Id:110})

# 2. Updating the newly inserted record above. 
db.transactions.update({Id:110},{$set:{Name:'Updated Record',Note:'Updated!'}})

# 3. Deleting record
db.transaction.remove({Id:110})
 (8) User Creation
See User Management with MongoDB.