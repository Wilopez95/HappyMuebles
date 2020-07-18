var Connection = require("tedious").Connection;
var config = {
    server: "localhost",
    authentication: {
        type: "default",
        options: {
            userName: "usuarioSQL",
            password: "admin"
        }
    },
    options: {
        database: "DBII_Muebleria",
        rowCollectionOnDone: true,
        useColumnNames: false,
        trustServerCertificate: true,
        encrypt: true
    }
}
var connection = new Connection(config);
connection.on("connect", function (err) {
    if (err) {
        console.log(err);
    } else {
        console.log("Connected");
    }
});
module.exports = connection;