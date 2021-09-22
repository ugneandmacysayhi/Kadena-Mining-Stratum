module.exports = {
  apps : [{
    name: 'ice-kadena',
    script: 'init.js',
    // Options reference: https://pm2.keymetrics.io/docs/usage/application-declaration/
    instances: 1,
    node_args: "--max-old-space-size=4096 --nouse-idle-notification",
    args: "--max-old-space-size=4096 --nouse-idle-notification --color",
    exec_mode: 'fork',
    autorestart: true,
    watch: false,
    max_memory_restart: '4G',
    env: {
      NODE_ENV: 'production',
      "interpreter_args": "--max-old-space-size=4096 --nouse-idle-notification"
    },
    env_production: {
      NODE_ENV: 'production'
    }
  }],

};
