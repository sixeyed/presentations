var redis = require("redis");
var elasticsearch = require('elasticsearch');
var os = require('os');

var sub = redis.createClient({host: 'redis'});

sub.on('connect', function() {
    console.log('connected');
});

var hostname = os.hostname();
var client = new elasticsearch.Client({
  host: 'elasticsearch:9200'
});

 
sub.on("message", function (channel, message) {
    console.log("sub channel " + channel + ": " + message);
    client.create({
  index: 'api-responses',
  type: 'ApiResponse',
  body: JSON.parse(message)
}, function (error, response) {
  //
});

});
 
sub.subscribe("api-responses");

console.log("Subscriber listening");