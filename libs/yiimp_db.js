var mysql = require('mysql')
var util = require('util')

var pool = mysql.createPool({
    timezone: "Z",
    connectionLimit: 20,
    host: "127.0.0.1",
    user: "root",
    password: "202A61d3f8085f0a913a07$d1a4ab19^3",
    database: "kdapool"
});

// Ping database to check for common exception errors.
pool.getConnection((err, connection) => {
    if (err) {
        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            console.error('Database connection was closed.')
        }
        if (err.code === 'ER_CON_COUNT_ERROR') {
            console.error('Database has too many connections.')
        }
        if (err.code === 'ECONNREFUSED') {
            console.error('Database connection was refused.')
        }
    }

    if (connection) connection.release()

    return
})

// Promisify for Node.js async/await.
pool.query = util.promisify(pool.query)

module.exports = pool



async function refresh() {
 var pid = process.pid;
 const timestamp = Math.round(+new Date()/1000);

 try {
//      logger.debug('YIIMP', 'YIIMP', '**** update yiimp timestamp=' + timestamp + ' pid=' + pid + ' pool=' + yiimpdb);
 
      var result = await yiimpdb.query(
        'UPDATE stratums SET time = ? WHERE pid = ?', [timestamp, pid])
      if (result) {
 //       logger.debug('YIIMP', 'YIIMP', 'Yiimp Refreshed')
      }
    } catch (err) {
      logger.error('YIIMP', 'YIIMP', 'Stratums update error: ' + JSON.stringify(err))
    }
};


