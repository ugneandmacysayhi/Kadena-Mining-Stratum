var yiimpdb = require('./yiimp_db.js');
//var mysql = require('mysql')
//var util = require('util')

async function refresh(logger, totalMinerCount) {

    var pid = process.pid;
    const timestamp = Math.round(+new Date() / 1000);
//    console.log("****** totalMinerCount=" + totalMinerCount + " pid=" + pid);

    try {
 /*       logger.debug(
            'YIIMP',
            'YIIMP',
            '**** update yiimp timestamp=' +
                timestamp +
                ' pid=' +
                pid +
                ' pool=' +
                yiimpdb,
        );
*/
        var result = await yiimpdb.query(
            'UPDATE stratums SET time = ?, workers = ? WHERE pid = ?',
            [timestamp, totalMinerCount, pid],
        );
        if (result) {
 //           logger.debug('YIIMP', 'YIIMP', 'Yiimp Refreshed');
        }
    } catch (err) {
        logger.error(
            'YIIMP',
            'YIIMP',
            'Stratums update error: ' + JSON.stringify(err),
        );
    }
}
function test() {
    console.log('testing');
}

module.exports = { refresh, test };
