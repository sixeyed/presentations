var db = require('./db.js');

exports.events = function (req, res) {
  console.log('Loading DB events...');
  db.Events
    .findAll()
    .then(events => {
        console.log('Fetched events, count: ' + events.length);
        res.json(events);
    })
    .catch(err => {
        console.error('** Fetch failed: ', err);
    });
};

exports.event = function (req, res) {
  console.log('Handling event call, method: ' + req.method + ', event ID: ' + req.params.eventId)
  switch(req.method) {
    case "DELETE":
      db.Events
      .destroy({
        where: {
          id: req.params.eventId
        }
      }).then(function() {
        console.log('Deleted event with id: ' + req.params.eventId)
        res.status(200).end();
      });
      break
    case "POST":
      db.Events
        .create({
          title: req.body.title,
          detail: req.body.detail,
          date: req.body.date
        })
        .then(function() {
          res.send('{}');
          res.status(201).end();
        });
      break
  }
};