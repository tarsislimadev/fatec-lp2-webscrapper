const { Client } = require('whatsapp-web.js'), qrcode = require('qrcode-terminal')

const client = new Client()

client.on('qr', (qr) => qrcode.generate(qr, { small: true }))

client.on('ready', () => console.log('Client is ready!'))

const commands = {
  ping: (msg) => msg.reply('pong'),
  echo: (...msg) => msg.reply(msg.join(' ')),
  news: (msg) => null, // fixme
}

client.on('message', (msg) => {
  if (msg.body.startsWith('/')) {
    const [command, ...args] = msg.body.slice(1).split(' ')
    const cmd = commands[command]
    cmd?.(msg, ...args)
  }
})

client.initialize()
