var express = require('express');
var os = require('os');
var redis = require("redis");

var pub = redis.createClient({host: 'redis'});
var hostname = os.hostname();

var app = express();

app.get('/', function (req, res) {

	var statusCode = 200;
	var mode = Math.floor(Math.random() * (11 - 1) + 1);
	if (mode == 1)            {
                statusCode = 500;
            }
            else if (mode < 5){
                statusCode = 503;
            }
   console.log("Sending response: %s", statusCode);

var apiResponse = {
    Timestamp: Date.now(),
    StatusCode: statusCode,
    Server: hostname
  };

pub.publish('api-responses', JSON.stringify(apiResponse));

   res.status(statusCode).send('');
})

var server = app.listen(5000, function () {

  var host = server.address().address
  var port = server.address().port

  console.log("Example app listening at http://%s:%s", host, port)

})