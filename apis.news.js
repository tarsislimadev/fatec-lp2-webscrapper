const request = (url) => fetch(url, { headers: { 'Content-Type': 'application/json' } }).then((res) => res.json())

module.exports = {
  v2: {
    everything: ({ q }) => request(`https://newsapi.org/v2/everything?q=${encodeURIComponent(q)}&apiKey=${process.env.NEWS_API_KEY}`),
  }
}
