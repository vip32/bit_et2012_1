show dbs
use test
db.blog.remove()
db.blog.dropIndexes()

// is it javascript?
1+1 

//insert
for (var i = 1; i <= 10000; i++) db.blog.save({author : "vip" + i, text : "my blog text"});
db.runCommand( "getlasterror" )

// help
db.blog.help()

//find
db.blog.find()
it
db.blog.find({author: "vip10"})
db.blog.find({author: "vip10"}).explain() // basiccursor

// index
db.blog.ensureIndex({author:1})
db.blog.find({author: "vip10"}).explain() // btree

//add tags
tag = {name: "new"}
db.blog.update({author: "vip10"}, {$push: {tags: tag}}, false, true)
db.blog.find()