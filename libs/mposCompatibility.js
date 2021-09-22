//var algos = require("stratum-pool/lib/algoProperties.js");
var cluster = require("cluster");
const poolRedis = require("./poolRedis");
//const poolNATS = require("./poolNATS");
const max = 2n ** 64n - 1n;
const { v4: uuidv4 } = require('uuid');

const coin_id = parseInt(process.env.COIN_ID);

const mysql = require("mysql");
//const poolNATS = require("./poolNATS");

module.exports = function (logger, poolConfig) {
  const mposConfig = poolConfig.mposMode;
  const coin = poolConfig.coin.name;

  const connection = mysql.createPool({
    host: mposConfig.host,
    port: mposConfig.port,
    user: mposConfig.user,
    password: mposConfig.password,
    database: mposConfig.database
  });

  const query = (...args) => {
    //console.log(`Running query ${args[0]} with data ${args[1]}`)
    return new Promise((resolve, reject) => {
      //console.log(`Running query ${args[0]} with data ${args[1]}`)
      connection.query(args[0], args[1], function (err, result) {
        if (err) reject(err);
        resolve(result);
      });
    });
  };

  const logIdentify = "MySQL";
  const logComponent = coin;

  // TODO


  let registerRedis = (async function () {
    const symbol = poolConfig.coin.symbol;
    const coinData = await query("SELECT id FROM coins WHERE symbol = ?", [
      symbol
    ]);
    //const coinid = coinData[0].id;
    console.log(".............Redis registrating............. coinid " + coin_id);
    //let results = await poolRedis.registerCoinid(coin_id).catch(err => {
    //  console.log("Redis registration failed:" + err);
    //});
  })();



  // var a = 12340000000000000000n;
  // var b = 1000000000000000000n;
  //console.log(Number(a * 100n / b) / 100);

  const formatBigInt = bigInt => {
    if (bigInt < 1000n) return Number(bigInt);
    if (bigInt >= 1000n && bigInt < 1000000n) return Number((bigInt * 100n / 1000n)) / 100 + 'k';
    if (bigInt >= 1000000n && bigInt < 1000000000n) return Number((bigInt * 100n / 1000000n)) / 100 + 'M';
    if (bigInt >= 1000000000n && bigInt < 1000000000000n) return Number((bigInt * 100n / 1000000000n)) / 100 + 'G';
    if (bigInt >= 1000000000000n && bigInt < 1000000000000000n) return Number((bigInt * 100n / 1000000000000n)) / 100 + 'T';
    if (bigInt >= 1000000000000000n && bigInt < 1000000000000000000n) return Number((bigInt * 100n / 1000000000000000n)) / 100 + 'P';
    if (bigInt >= 1000000000000000000n && bigInt < 1000000000000000000000n) return Number((bigInt * 100n / 1000000000000000000n)) / 100 + 'E';
  };

  //console.log(formatBigInt(122223n));

  //console.log("cluster.worker=" + console.dir(cluster.worker));
  // Create Stratum
  //console.log("cluster.worker.id=" + cluster.worker.id);

  if (cluster.worker.id == 1) {
    var ports = Object.keys(poolConfig.ports);
    const pid = process.env.pid;
    const timestamp = Math.round(+new Date() / 1000);
    const algo = poolConfig.coin.algorithm;
    // const url = "url";
    const port = ports[0];
    const symbol = poolConfig.coin.symbol;
    // todo where do we get the current stratum port????

    try {
      //console.log("****** insert stratums pid=" + pid);
      const result = query(
        "INSERT INTO stratums (pid, time, started, algo, workers, port, symbol) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [pid, timestamp, timestamp, algo, 0, port, symbol]
      );
    } catch (err) {
      logger.error(
        logIdentify,
        logComponent,
        "Unable to insert stratum: " + JSON.stringify(err)
      );
    }

    let NATSData = [
      parseInt(pid),
      timestamp,
      timestamp,
      algo,
      0,
      parseInt(port),
      symbol,
      poolConfig.stratum_id,
      coin_id,
    ];

    //poolNATS.send("dev.stratum.start.2423", NATSData)


  }

  function roundFix(number, precision) {
    var multi = Math.pow(10, precision);
    return Math.round((number * multi).toFixed(precision + 1)) / multi;
  }


  //
  // Auth
  //
  this.handleAuth = async function (stratum_id, rawip, version, port, workerName, password, authCallback) {
    console.log(`auth: ${rawip} ${workerName} ${password} version:${version} stratum_id ${stratum_id}`);
    const ip = /\d.*/.exec(rawip)[0];
    if (!password) password = "NULL";

    //console.log(`ip = ${ip}, version = ${version}`);
    if (poolConfig.validateWorkerUsername !== true && mposConfig.autoCreateWorker !== true) {
      console.log("****************** handleAuth no validate user no auto create user.. untested logic!\n");
      authCallback(true, iceWorkerId, iceUserId, iceCoinId)
      return;
    }


    const symbol = poolConfig.coin.symbol;
    const coinData = await query('SELECT id FROM coins WHERE symbol = ?', [symbol])
    const wallet = workerName.split('.')[0];
    const rigname = workerName.split('.')[1];
    const pid = process.env.pid;
    const timestamp = Math.round(+new Date() / 1000);

    const coinid = coinData[0].id;
    const algo = poolConfig.coin.algorithm;
    // const port = poolConfig.initStats.stratumPorts[0];
    const url = "url";
    const accountData = await query('SELECT id FROM accounts WHERE username = ?', [wallet]);

    // ****** TODO handle password and -p c= and -p mp=
    var ports = Object.keys(poolConfig.ports)[0];

    // data to pass back to stratum-pool
    var callbackData = {
      uuid: uuidv4(),
      iceCoinId: coin_id,
      iceUserId: null,
      iceWorkerId: null,
      difficulty: null,// or hard code a test number
      mode: "", // solo by default
      party_pass: ""
    };

    // Handle password
    let stratumDiff = poolConfig.ports[port].diff;
    // let mode = 0;
    let party_pass = "";
    //console.log("stratumDiff:" + stratumDiff);
    var solo_regex = /m=solo/;
    var party_regex = /m=party.(\w+)/;
    //var str = "m=solo".toLowerCase();
    // var str = "m=party.1234567890".toLowerCase();
    var tag = password.match(solo_regex);
    //console.log("tag is " + tag);

    if (tag) {
      //console.log("SOLO MODE");
      callbackData.mode = "solo"; // solo
    } else {
      tag = password.match(party_regex);
      if (tag) {
        callbackData.mode = "party";
        callbackData.party_pass = tag[1].substring(0, 8);
        //console.log("party mode. party pass " + callbackData.party_pass);
      }
    }
    //console.log("mode is " + mode);
    /*
        let regPassResult = /d=(\d+(\.\d{1,2})?)\d*?/.exec(password);
        if (regPassResult) {
          stratumDiff = parseFloat(regPassResult[1]);
          let maxDiff = poolConfig.ports[port].varDiff.maxDiff;
          let minDiff = poolConfig.ports[port].varDiff.minDiff;
          if (stratumDiff >= minDiff && stratumDiff <= maxDiff) {
            callbackData.difficulty = stratumDiff;
          }
        }
    */
    /*
          // Handle mp= in password
          let regMpResult = /mp=(\d+(\.\d)?)\d*?/.exec(password);
          let minPayout = null;
          if (regMpResult){
            let mp = parseFloat(regMpResult[1]);
            if (mp >= 0.1 && mp <= 1000000){
              minPayout = mp;
            }
          }
    */
    try {
      const time = Math.round(+new Date() / 1000);
      if (!accountData[0]) {
        const accounts = await query('INSERT INTO accounts (coinid, username, balance, donation, hostaddr) values (?, ?, 0, 0, ?);', [coin_id, wallet, ip]);

        console.log("DEBUG New Account:" + wallet + " userid:" + accounts.insertId + " ip:" + ip + " uuid: " + uuid);
        callbackData.iceUserId = accounts.insertId;
        callbackData.iceCoinId = coin_id; //todo needed?
        callbackData.uuid = uuid;


        result = await query('INSERT INTO workers (userid, coinid, ip, name, difficulty, version, password, worker, algo, time, pid, mode, party_pass) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [callbackData.iceUserId, coin_id, ip, wallet, stratumDiff, version, password, rigname, algo, timestamp, pid, callbackData.mode, callbackData.party_pass])
        callbackData.iceWorkerId = result.insertId;
        authCallback(true, callbackData);
      } else if (rigname !== 'noname' && rigname != '') {
        let userid = accountData[0].id;
        callbackData.iceUserId = userid;
        //console.log(`wallet ${wallet} version ${version} rigname ${rigname} pid ${pid} userid ${userid}`);
        //console.log(`DEBUG attempt to wire up existing rigname. wallet ${wallet} version ${version} rigname ${rigname} pid ${pid}`);
        const workerData = await query('SELECT id FROM workers WHERE coinid=? AND userid=? AND worker=?', [coin_id, userid, rigname]);
        if (workerData[0]) {
          //console.log(`case I`);
          //I: re-use existing rigname`);
          callbackData.iceWorkerId = workerData[0].id;
          const result = await query("UPDATE workers SET time=?,pid=? WHERE id = ?", [time, pid, callbackData.iceWorkerId]);
          authCallback(true, callbackData);
        } else {
          //console.log(`DEBUG CASE II: no existing worker`);
          result = await query('INSERT INTO workers (userid, coinid, ip, name, difficulty, version, password, worker, algo, time, pid, mode, party_pass) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [userid, coinid, ip, wallet, stratumDiff, version, password, rigname, algo, timestamp, pid, callbackData.mode, callbackData.party_pass])
          callbackData.iceWorkerId = result.insertId;
          callbackData.iceUserId = userid;
          callbackData.iceCoinId = coin_id;
          authCallback(true, callbackData);
        }
      } else { // account but no rigname set
        //console.log(`DEBUG CASE III: existing no-name worker?????`);
        const userid = accountData[0].id;
        result = await query('INSERT INTO workers (userid, coinid, ip, name, difficulty, version, password, worker, algo, time, pid, mode, party_pass) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [userid, coinid, ip, wallet, stratumDiff, version, password, rigname, algo, timestamp, pid, callbackData.mode, callbackData.party_pass])
        callbackData.iceWorkerId = result.insertId;
        callbackData.iceUserId = userid;
        callbackData.iceCoinId = coin_id;
        authCallback(true, callbackData);
      }
    } catch (err) {
      console.error(err);
      logger.error(logIdentify, logComponent, 'DEBUG Database error when authenticating account: ' + JSON.stringify(err))
      authCallback(false, callbackData);
    }

    // NATS Auth
    try {
      //TODO
      const NATSData = [
        wallet,
        coin_id,
        ip,
        parseFloat(stratumDiff),
        version,
        "",
        rigname,
        callbackData.uuid,
        "blake2s",
        Math.floor(timestamp),
        stratum_id,
        callbackData.mode,
        callbackData.party_pass,
        parseInt(pid),
      ];

      //poolNATS.send('dev.stratum.auth.2423', NATSData);

    } catch (err) {
      console.log("error sending NATS auth: " + err);
    }



  }
  // };



  //
  // Share
  //
  this.handleShare = async function (isValidShare, isValidBlock, shareData) {
    //console.log("handleShare shareData: " + JSON.stringify(shareData))
    const wallet = shareData.worker.split(".")[0];
    const rigname = shareData.worker.split(".")[1];
    // const symbol = poolConfig.coin.symbol;
    const timestamp = parseInt(Date.now() / 1000);
    //handleShare " + JSON.stringify(shareData));
    //console.log("mpos share difficulty=" + shareData.difficulty+ " share_diff=" + shareData.shareDiff + ", blockDiff=" + shareData.blockDiff + "");

    //if (!shareData.blockReward) {
    //shareData.blockReward = 66.64000000000;
    //process.stdout.write(" [blockReward is NULL]");
    //}

    // if (shareData.stratum_id == "US") stratum_id = 0;
    // else if (shareData.stratum_id == "EU") stratum_id = 1;

    if (isValidShare) {
       let redisData = [
         shareData.iceUserId,
         shareData.iceWorkerId,
         shareData.iceCoinId,
         timestamp,
         "blake2s",
         1,
         shareData.difficulty, // algos[poolConfig.coin.algorithm].multiplier,
         shareData.shareDiff,
         shareData.blockReward, // 100000000,
         shareData.blockDiff,
         shareData.mode,
         shareData.party_pass
       ];
       //console.log("insert share. yiimpUserId=" + shareData.iceUserId+ " yiimpWorkerId=" + shareData.iceWorkerId+ " yiimpCoinId= " + shareData.iceCoinId+ " redisData=" + JSON.stringify(redisData));
       await poolRedis.sendShare(shareData.iceCoinId, redisData).then(() => {
         logger.debug(logIdentify, logComponent, 'Share inserted')
      });


      // console.log(`block reward: ${ shareData.blockReward } full block: `, JSON.stringify(shareData));
      //try {
       // const result = await query(
       //   "INSERT INTO shares (userid, workerid, coinid, time, difficulty, share_diff, algo, reward, blockDiff, height) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
       //   [
       //     shareData.iceUserId,
       //     shareData.iceWorkerId,
       //     2423,
       //     timestamp,
       //     shareData.difficulty,
       //     shareData.shareDiff,
       //     "blake2s",
       //     shareData.blockReward,
       //     shareData.blockDiff,
       //    shareData.height,
       //   ]
       // );

       // if (result) {
          //logger.debug(logIdentify, logComponent, 'Share inserted')
        //}

     // } catch (err) {
       // logger.error(
       //   logIdentify,
        //  logComponent,
        //  "Insert error when adding block: " + JSON.stringify(err)
       // );
      //}
    }


    // TODO Blocks shoudl go into publish also, another queue group icems will handle this for more reliability
    if (isValidBlock) {
      if (shareData.shares > max) {
        console.log("*** ERROR shares > BigInt max!");
      }

      shareData.shares = BigInt(1000000);

      const sharesStr = formatBigInt(shareData.shares);
      const blockDiffStr = formatBigInt(BigInt(shareData.blockDiff));
      //.asUintN(64, max
      //let effort = parseFloat(shareData.duration / 30).toFixed(1);
      //     if (bigInt >= 1000n && bigInt < 1000000n) return Number((bigInt * 100n / 1000n)) / 100 + 'k';

      let duration = parseFloat(shareData.duration / 1000).toFixed(1);
      let effort = Number((shareData.shares * 10000n / BigInt(shareData.blockDiff))) / 100
      //let effort = Number((100n * BigInt(shareData.blockDiff) / shareData.shares) / 100);
      console.log(`*** BLOCK Duration: ${duration}s Luck: ${effort}% ${sharesStr} shares BlockDiff ${blockDiffStr} ${shareData.blockHash}`);

      let blockMode = "normal";
      // if (shareData.mode == 1)
      //   blockMode = "solo";
      // if (shareData.mode == 2)
      //   blockMode = "party";

      try {

        // console.log(`block reward: ${ shareData.blockReward } full block: `, JSON.stringify(shareData));
        const result = await query(
          "INSERT INTO kdablocks (coin_id, time, userid, workerid, height, chainid, algo, category, difficulty_user, amount, difficulty, blockhash, txhash, stratum_id, node_id, mode, party_pass, duration, shares) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
          [
            shareData.iceCoinId,
            timestamp,
            shareData.iceUserId,
            shareData.iceWorkerId,
            shareData.height,
            shareData.chainId,
            poolConfig.coin.algorithm,
            "new",
            shareData.shareDiff,
            shareData.blockReward,
            shareData.blockDiff,
            shareData.blockHash,
            shareData.txHash,
            shareData.stratum_id,
            shareData.node_id,
            blockMode,
            shareData.party_pass,
            shareData.duration,
            shareData.shares
          ]
        );

        if (result) {
          logger.debug(logIdentify, logComponent, 'Block inserted')
        }

      } catch (err) {
        logger.error(
          logIdentify,
          logComponent,
          "Insert error when adding block: " + JSON.stringify(err)
        );
      }
      let NATSBlockData = [
        coin_id,
        shareData.height,
        timestamp,
        wallet,
        "anon",
        rigname,
        0,
        parseFloat(shareData.blockReward),
        shareData.difficulty,
        shareData.shareDiff,
        shareData.blockHash,
        "blake2s", // Note: algo is a string on blocks, but int on shares
        "new",
        shareData.stratum_id,
        shareData.chainId,
        shareData.node_id,
        blockMode,
        shareData.party_pass,
        shareData.duration,
        Number(shareData.shares)
      ];

      console.log("KDABlock: " + JSON.stringify(NATSBlockData));

      //poolNATS.send("dev.stratum.kdablocks", NATSBlockData);
    }
  };


  //
  // Diff
  //
  this.handleDifficultyUpdate = async function (workerName, diff, iceWorkerId) {
    //console.log("MPOS ****** workerName=" + workerName + " diff=" + diff + " iceWorkerId=" + iceWorkerId);
    //diff = diff.toNumber();

    // if (diff > 10) diff = roundFix(diff, 0);
    // else if (diff < 1) diff = roundFix(diff, 3);
    // else diff = roundFix(diff, 2);

    try {
      const result = await query(
        "UPDATE workers SET difficulty = ? WHERE id = ?",
        [diff, iceWorkerId]
      );
      if (result.affectedRows === 0) {
        // todo needed?? const insertResult = await query('INSERT INTO `pool_worker` SET ?', { username: workerName, difficulty: diff })
        logger.debug(
          logIdentify,
          logComponent,
          "Updated difficulty successfully" + insertResult
        );
      }
    } catch (err) {
      /*
          logger.error(
            logIdentify,
            logComponent,
            "Error when updating worker diff: " +
              diff +
              " iceWorkerId=" +
              iceWorkerId +
              " worker:" +
              workerName +
              " error=" +
              JSON.stringify(err)
          );*/
    }
  };

  this.handleDisconnect = async function (iceWorkerId, workerName, uuid) {
    //console.log("mpos handleDisconnect workerId " + iceWorkerId + " workerName " + workerName + " uuid " + uuid);
    if (!iceWorkerId) return;

    try {
      const result = await query("DELETE from workers WHERE id = ?", [
        iceWorkerId
      ]);
      if (result.affectedRows === 0) {
        // todo needed?? const insertResult = await query('INSERT INTO `pool_worker` SET ?', { username: workerName, difficulty: diff })
        //logger.debug(logIdentify, logComponent, 'Updated difficulty successfully' + insertResult)
      }

      const NATSData = [
        workerName, uuid
      ];

      poolNATS.send('dev.stratum.disconnect.2423', NATSData);

    } catch (err) {
      logger.error(
        logIdentify,
        logComponent,
        "Error when cleaning up worker id : " + iceWorkerId
      );
    }
  };
};


