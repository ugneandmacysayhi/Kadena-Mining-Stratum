const redis = require('redis');
const bluebird = require('bluebird');

const client = redis.createClient({
  port: 6379,
  host: '127.0.0.1'
}
);

bluebird.promisifyAll(client);

client.on('error', function (err) {
  console.log('Message Redis Client Error ' + err);
});

const reportErr = e => {
  console.log('Promoise Error');
  console.log(e);
};

var accountSet;

module.exports = class poolRedis {
  //constructor(coinConfig){
  //this.coinConfig = coinConfig;
  //this.publish(JSON.stringify(this.coinConfig));
  //}

  // ex: AccountCache:<wallet> userid 12345
  // ex: AccountCache:<wallet> coinid 2089
  static async hset(username, field, value) {
    let para = ['AccountCache:' + username, field, value];
    var account = client.hset(['AccountCache:' + username, field, value]);
    client.expire(`AccountCache:${username}`, 5/*86400*/);
  }


  static async getAccount(username) {
    let res = await client.hgetallAsync(`AccountCache:${username}`);
    return res;

    //if (err) console.log(err);
    //if (results != null) {
    // 
    //return results;
  }

  static async sendShare(coinid, shareData) {
    //console.log('ShareStream-' + coinid, '*', 'data', JSON.stringify(shareData));
    return client
      .xaddAsync(
        'ShareStream-' + coinid,
        '*',
        'data',
        JSON.stringify(shareData),
      )
      .catch(reportErr);
  }

  static async getShares(coinid, count) {
    let para = ['ShareStream-' + coinid, '+', '-'];
    if (count) {
      para.push('COUNT', '' + count);
    }
    // return client.xrevrangeAsync('ShareStream-' + coinid, '+', '-').catch(reportErr);
    return client.xrevrangeAsync(...para).catch(reportErr);
  }

  static async getSharesCallback(coinid, count) {
    let para = ['ShareStream-' + coinid, '+', '-'];
    if (count) {
      para.push('COUNT', '' + count);
    }
    console.log('tic' + new Date());
    client.xrevrange(...para, (err, data) => {
      if (err) {
        console.log(err);
      } else {
        console.log('toc' + new Date());
        console.log(data.length);
      }
    });
  }

  static async trimShares(coinid, maxlen) {
    return client
      .xtrimAsync('ShareStream-' + coinid, 'MAXLEN', '~', '' + maxlen)
      .catch(reportErr);
  }

  static async publish(msg) {
    return client.publishAsync('MessageHub', msg).catch(reportErr);
  }

  static async registerCoinid(coinid) {
    return client
      .publishAsync(
        'MessageHub',
        JSON.stringify({ msg: 'register', coinid: coinid }),
      )
      .catch(reportErr);
  }
};
