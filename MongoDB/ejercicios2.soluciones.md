**Answer**

1. db.movies.find()
2. db.movies.find({writer: "Quentin Tarantino"})
3. db.movies.find({actors: "Brad Pitt"})
4. db.movies.find({franchise: "The Hobbit"})
5. db.movies.find({$and: [{year: {$gt: 1900}}, {year: {$lt: 2000}}]})
6. db.movies.find({$or: [{year: {$lt: 2000}}, {year: {$gt: 2010}}]})

UPDATE

1. db.movies.update({title: "The Hobbit: An Unexpected Journey"}, {synopsis: "A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home - and the gold within it - from the dragon Smaug."})
2. db.movies.update({title: "The Hobbit: The Desolation of Smaug"}, {synopsis: "The dwarves, along with Bilbo Baggins and Gandalf the Grey, continue their quest to reclaim Erebor, their homeland, from Smaug. Bilbo Baggins is in possession of a mysterious and magical ring."})
3. db.movies.update({title: "Pulp Fiction"}, {$push: {actors: "Samuel L. Jackson"}})

TEXT SEARCH

1. db.movies.find({$text: {$search: "Bilbo"}})
2. db.movies.find({$text: {$search: "Gandalf"}})
3. db.movies.find({$text: {$search: "Bilbo -Gandalf"}})
4. db.movies.find({$text: {$search: "dwarves hobbit"}})
5. db.movies.find({$text: {$search: "gold dragon"}})

DELETE DOCUMENT

1. db.movies.remove({title: "Pee Wee Herman's Big Adventure"})
2. db.movies.remove({title: "Avatar"})

LAST PART

1. db.users.find()
2. db.posts.find()
3. db.posts.find({username: "GoodGuyGreg"})
4. db.posts.find({username: "ScumbagSteve"})
5. db.comments.find()
6. db.comments.find({username: "GoodGuyGreg"})
7. db.comments.find({username: "ScumbagSteve"})