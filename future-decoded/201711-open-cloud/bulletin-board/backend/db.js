var Sequelize = require('sequelize');
var username = 'sa';
var password = 'DockerCon!!!';
var host = 'sql-db';
var dbName = 'BulletinBoard';

var sequelize = new Sequelize(dbName, username, password, {
    dialect: 'mssql',
    host: host,
    port: 1433,
    dialectOptions: {
        requestTimeout: 30000
    }
});

sequelize
    .authenticate()
    .then(() => {
        console.log('Successful connection to SQL Server.');
    })
    .catch(err => {
        console.error('** SQL Server connection failed: ', err);
    });

var Event = sequelize.define('event', {
    title: Sequelize.STRING,
    detail: Sequelize.STRING,
    date: Sequelize.DATE
});

Event.sync();

exports.Events = Event;

/*
exports.events = function (req, res) {
    Event
            .findAll()
            .then(events => {
                console.log('Fetched events, count: ' + events.length);
                return events;
            })
            .catch(err => {
                console.error('** Fetch failed: ', err);
            });
};
*/
