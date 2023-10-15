const express = require('express');
const app = express();
const router = express.Router();
const path = __dirname + '/views/';
const port = 8080;

//Take values from DB and put into file
let mysql = require('mysql');
let fs = require('fs')
let connection = mysql.createConnection({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE
});
connection.connect(function(err) {
  if (err) {
    return console.error('error: ' + err.message);
  }
  connection.query("SELECT * FROM information_schema.tables WHERE table_schema = 'nodejsdb' AND table_name = 'nodejstb' LIMIT 1;",function (err, result, fields) {
    if (err) throw err;
    console.log(result);
   if (result.length === 0) {
    connection.query("CREATE TABLE nodejstb (nodejsmessage VARCHAR\(100\));",function (err, result, fields) {
      if (err) throw err;
      console.log(result);
    });
    connection.query("INSERT INTO nodejstb VALUE \('Hello World'\);",function (err, result, fields) {
      if (err) throw err;
      console.log(result);
    });
    connection.query("SELECT * FROM nodejstb;",function (err, result, fields) {
      if (err) throw err;
      console.log(result[0].nodejsmessage);

      try {
        fs.writeFileSync('views/index.html', result[0].nodejsmessage)
      } catch (err) {
        console.error(err)
      }
    });
    connection.end(function(err) {
     if (err) {
       return console.log('error:' + err.message);
     }
     console.log('Close the database connection.');
    });
   }else {
    connection.query("SELECT * FROM nodejstb;",function (err, result, fields) {
        if (err) throw err;
        console.log(result[0].nodejsmessage);

        try {
            fs.writeFileSync('views/index.html', result[0].nodejsmessage)
        } catch (err) {
            console.error(err)
        }
    });
      connection.end(function(err) {
       if (err) {
         return console.log('error:' + err.message);
       }
       console.log('Close the database connection.');
      });
    }
  });
});
//
router.use(function (req,res,next) {                                 
    console.log('/' + req.method);
    next();               
});    
router.get('/', function(req,res){
    res.sendFile(path + 'index.html');
});            
//router.get('/sharks', function(req,res){        
//    res.sendFile(path + 'sharks.html');
//});                                              
app.use(express.static(path));
app.use('/', router);
app.listen(port, function () {
console.log('Example app listening on port 8080!')
})
