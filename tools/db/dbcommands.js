use trackingdb
db.records.ensureIndex({"login":1,"ux":1})
db.records.ensureIndex({"login":1,"hr":1})
db.records.ensureIndex({"ux":1})

db.records.count()
db.records.find({login: "10199", "hr":22})
db.records.count({login: "10199", "hr":22})

db.statrecords.remove()
db.statrecords.find()
db.statrecords.update({account:"vip32", site: "sitename1"}, {$inc: {"sum": 1}}, true)

// get record count for a specific login
db.records.group(
   { 
     key: {login: true}
   , cond: {login: "10199"}
   , initial: {count: 0}
   , reduce: function(doc, out){ out.count++ }
   //, finalize: function(out){ out.count }
   } );


 // get record count for a specific login at a given time
use trackingdb
db.records.group(
   { 
     key: {login: true}
   , cond: {login: "10199", "hr":22}
   , initial: {count: 0}
   , reduce: function(doc, out){ out.count++ }
   //, finalize: function(out){ out.count }
   } );


var t = Math.round((new Date()).getTime() / 1000)
//db.records.count({login: "10199", "ux" : {$gt: t}})

// records for the last minute
var t = Math.round((new Date()).getTime() / 1000);db.records.count({login: "10199", "ux" : {$gt: (t-60)}}) 
// records for the last hour
var t = Math.round((new Date()).getTime() / 1000);db.records.count({login: "10199", "ux" : {$gt: (t-(60*60))}}) 
// records for last 24 hour
var t = Math.round((new Date()).getTime() / 1000);db.records.count({login: "10199", "ux" : {$gt: (t-(s60*60*24)0}}) 