const { Client } = require('whatsapp-web.js'), qrcode = require('qrcode-terminal')

const apis = require('./apis.js')

const client = new Client({
  puppeteer: {
    executablePath: process.env.PUPPETEER_EXECUTABLE_PATH,
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
  },
})

client.on('qr', (qr) => qrcode.generate(qr, { small: true }))

client.on('ready', async () => {
  const chats = await client.getChats()
  console.log(`Chats: ${chats.map((chat) => chat.name).join(';; ')}.`)
})

const commands = {
  ping: (msg) => msg.reply('pong'),
  echo: (msg, text) => msg.reply(text),
  news: (msg, text) => apis.news.v2.everything({ q: text }).then((res) => msg.reply(res.articles?.[0]?.title || 'No news found')),
}

client.on('message_create', (msg) => {
  if (msg.body.startsWith('/')) {
    const [command, ...args] = msg.body.slice(1).split(' ')
    const cmd = commands[command]
    cmd?.(msg, ...args)
  }
})

client.initialize()
