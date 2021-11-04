## This repo is looking for maintainers! Please reach out if interested.

<p align="center">
  <img src="https://cmpool.io/mine.png" width="250" title="hover text">
</p>

#### Kadena Mining Stratum ####
* Allows ASIC miners for the Kadena Blockchain to be able to talk directly with a Chainweb-Node eliminating the need to rely on third party pools to mine a free and open source Blockchain.

A very special thanks to Greg from [Icemining](https://icemining.ca/)

#### Dependencies ####
The Kadena Mining stratum was built on and tested with Ubunutu 20.04.2 LTS 

The Kadena Mining Stratum is Dependant on the Kadena [Chainweb-Node](https://github.com/kadena-io/chainweb-node)

To install the Kadena Mining Stratum:

#### Dependencies #### <br>
> apt update <br>
> apt upgrade <br>
> apt install nodejs mysql-server redis-server
<br>

#### Configuring sql #### <br>
First setup mysql with new password <br>
> mysql_secure_installation <br>
> Change the root password? [Y/n] y <br>
> Remove anonymous users? [Y/n] n <br>
> Disallow root login remotely? [Y/n] y <br>
> Remove test database and access to it? [Y/n] y <br>
> Reload privilege tables now? [Y/n] y <br>

Import the pool.sql file to create the necessary tables 
> mysql -u username -p kdapool < pool.sql


#### Configuring Chainweb #### <br>
Second run the Chainweb-Node with the provided config.yaml file, make sure to edit the hostname (your WAN IP) and change the account and public keys to match the wallet you would like to mine to, as well as the port if desired. 
> ./Chainweb-node --config-file=config.yaml
#### IMPORTANT! do not run the stratum untill the node is synced up with the rest of the network!! ####
It can take a very long time for the node to sync up so be patient, check https://yourip:port/chainweb/0.0/mainnet01/cut in a browser to see what the current block height of your node is and compare it with the [Block Explorer](https://explorer.chainweb.com/mainnet), do not run the stratum untill your node matches the height of the explorer. 


#### Running the stratum #### <br>
Lastly, run the init.js script found in the stratum folder making sure to change the public keys and mysql password in the stratum/.env file as well as the ports for the stratum if desired in the pool_configs/kadena.json file 
You will also need to make sure that the ports you have configured are open and forwarded correctly.
>node init.js 



**Example stratum/.env file  <br>**
>SOLVED=/chainweb/0.0/mainnet01/mining/solved <br>
>WORK=/chainweb/0.0/mainnet01/mining/work <br>
>PUBKEY=caf062921c1b781f69f20c5c4ad7e697262017dd98a59380e3b3f16308ae5a90(your wallet here) <br>
>CUT=/chainweb/0.0/mainnet01/cut <br>
>PORT=3443 <br>
>NODE_NET=mainnet01 <br>
>NODE1=YourIp <br>
>NODE2=IpOfBackupNode1 <br>
>NODE3=IpOfBackupNode2 <br>
>STRATUMID=US <br>
>COIN_ID=2423 <br>

**Note: NODE1, NODE2, AND NODE3 can all be the same node, but ideally it is best to have at least one backup node. 
**



**Example pool_configs/kadena.json file**                                                                                            

    "address": "",

    "rewardRecipients": {
        "RDsffBxPZh2SXonPPhvER8cCUwaeaeHbRq": 0.0
    }, 

    "paymentProcessing": {
        "enabled": false,
        "paymentInterval": 20,
        "minimumPayment": 70,
        "daemon": {
            "host": "127.0.0.1",
            "port": 19332,
            "user": "testuser",
            "password": "testpass"
        }
    },

    "ports": {
        "3700": {
            "diff": 17592186044416 
        },
        "3701": {
                "diff": 1099511627776 
        }
    },
    "daemons": [
        {
            "host": "YOUR_WAN_IP",
            "port": 443,
            "user": "",
            "password": ""
        }
    ],

    "p2p": {
        "enabled": false,
       "host": "127.0.0.1",
        "port": 8767,
        "disableTransactions": false
    },

    "mposMode": {
        "enabled": true,
        "host": "127.0.0.1",
        "port": 3306,
        "user": "root",
        "password": "MY_SQL_DB_ROOT_PASSWORD",
        "database": "MYSQL_DB_NAME",
        "checkPassword": false,
        "autoCreateWorker": true
    }









It is reccomended to run both the Stratum and the Chainweb-node using something like tmux so that neither will die upon ssh disconnect. <br>
>apt install tmux <br>
> https://tmuxcheatsheet.com/ <br>



Happy Mining! <br>


**I will be happy to help you get the stratum setup from start to finish for a one time fee, please reach out via discord or telegram to harmonic if interested.** 
If you have any issues or need assistance please reach out via: <br>
Discord: https://discord.gg/mrmfBWGUVh <br>
Telegram: https://t.me/cmpool_io_chat <br> 


#### Dontations are highly appreciated!! ####
KDA: caf062921c1b781f69f20c5c4ad7e697262017dd98a59380e3b3f16308ae5a90 <br>
BTC: 3Mdes4zKuEBtS7xTCKZSarP3dApNGFNuEC <br> 
ETH: 0xFb52a503F129C5e38F8b815e06C8EbDA41D313DD 
