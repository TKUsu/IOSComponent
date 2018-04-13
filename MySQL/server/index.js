const mysql = require('mysql');
const bodyParser = require('body-parser');
const express = require('express'), 
    app = express();

app.use(bodyParser.json());

var server = app.listen(3000);

app.get('/', function (req, res) {
    console.log("IP: %s is connect..", req.hostname);
    res.send("Hello "+ req.hostname);
});
var user;
app.post('/', function(req, res) {
    console.log('Success!')
    user = req.body;
    console.log("name: " + user.name);
    console.log("password: " + user.password);
    res.send({
        'status':'Success',
        'user':{
            'name': user.name,
            'email': '123@gmail.com'
        }
    })
    db("testdb");
});
//SQL
var host = 'host'
var root = 'root'
var password = 'password'
/** Database connect
var con = mysql.createConnection({
  host: host,
  user: user,
  password: password
});
 
function db() {
    var dbname = "testdb";
    con.connect(function(err) {    
        if (err) throw err;
        console.log("============================\n\tConnected!");
        con.query("use " + dbname, function (err, result) {
            if (err) throw err;
            console.log("Use " + dbname);
        })
    });
}*/
//table connect
function db(dbname) {
    var dbcon = mysql.createConnection({
        host: host,
        user: root,
        password: password,
        database: dbname
    });
    dbcon.connect(function(err){
        if (err) throw err;
        var table = 'account'
        console.log("==========================\nDB: " + dbname + " Connected!");
        var query = "name VARCHAR(255) NOT NULL, password VARCHAR(255) NOT NULL";
        //Create 'account' table
        // createTable(dbcon, 'account', query);
        //Select table
        dbcon.query("SELECT * FROM " + table, function (err, result, fields) {
            if (err) {
                console.log(err);
            };
            //insert data to select table
            insert(dbcon, table, '(name, password)', 
                "('"+ user.name +"', '"+ user.password +"')");
            //search data from table
            where(dbcon, table, 'name', '001');
            //order of table
            order(dbcon, table, 'name');
            //delete data from table
            // deleteValue(dbcon, table, 'name', '001');
        });
    });
}

function createDB(con, name) {
  con.query("CREATE DATABASE " + name, function (err, result) {
    if (err) throw err;
    console.log("'"+name+"'" + " database created");
  });
}

/**
    elete table query: DROP TABLE 'table name'
    var query = "(name VARCHAR(255), address VARCHAR(255)";
    add key into exists table
    query: `ALTER TABLE customers ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY`
*/
function createTable(dbcon, name, query){
    var sql = "CREATE TABLE " + name + " ("+ query +")";
    dbcon.query(sql, function (err, result) {
        if (err) throw err;
        return {
            error: function () {
                return "Table: " + name + " created!"
            }
        }        
    });
}

function insert(dbcon, table, key, value) {
    var sql = "INSERT INTO "+ table +" "+ key +" VALUES "+ value;
    dbcon.query(sql, function (err, result) {
        if (err) throw err;
        console.log("++++++++++++  Insert  ++++++++++++");
        console.log( "1 record inserted -> (key: "+ key +", value: "+ value +")");
    });
}

/*
    select table colume limit
    query: `SELECT * FROM customers LIMIT 5`
    starting from postion 2
    query: `SELECT * FROM customers LIMIT 5 OFFSET 2`
    Return 5 customers, starting from position 2:
    query: `SELECT * FROM customers LIMIT 2, 5`
*/

function where(dbcon, table, key, value) {
    dbcon.query("SELECT * FROM "+ table +" WHERE "+ key +" = '"+ value +"'", function (err, result) {
        if (err) throw err;
        console.log("***********   where    *************");
        console.log( result);
    });
}

function order(dbcon, table, key) {
    dbcon.query("SELECT * FROM "+ table +" ORDER BY "+ key, function (err, result) {
        if (err) throw err;
        console.log("************   Oder    *************");
        console.log( result);
    });
}

function deleteValue(dbcon, table, key, value) {
    var sql = "DELETE FROM "+ table +" WHERE "+ key +" = '"+ value +"'";
    dbcon.query(sql, function (err, result) {
        if (err) throw err;
        console.log("------------  delete  --------------");
        console.log("Number of records deleted: " + result.affectedRows);
    });
}
//query: `UPDATE table SET key = newValue WHERE key1 = 'value1' AND key2 = 'value2';`
function update(dbcon, table, key) {
    var sql = "UPDATE "+ table + " " + key;
    dbcon.query(sql, function (err, result) {
        if (err) throw err;
        console.log(result.affectedRows + " record(s) updated");
    });
}

function setSafeUpdateMode(dbcon, table, flag) {
    dbcon.query("SET SQL_SAFE_UPDATES="+flag, function (err, result) {
        if(err) throw err;
        console.log(result);        
    })
}

/*  Join Two or More Tables
    ...
*/