const express = require('express'); 

function eRoutes() {
    const router = express.Router();
    var forniture = require('./repository/forniture/forniture.routes')
    return router;
}

module.exports = eRoutes;