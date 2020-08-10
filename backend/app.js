var express = require('express');
var bodyParser = require('body-parser');
var cors = require('cors')


var app = express();

var port = process.env.port || 3300

app.listen(port, () => {
    console.log("Hi This port is running");
});

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cors())

var router = require('./routes')();
 
app.use('/api', router);

