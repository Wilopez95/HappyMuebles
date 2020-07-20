var express = require('express');
var bodyParser = require('body-parser');


var app = express();

var port = process.env.port || 3300

app.listen(port, () => {
    console.log("Hi The server is running on port: "+ port);
});

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var router = require('./routes')();
 
app.use('/api', router);


