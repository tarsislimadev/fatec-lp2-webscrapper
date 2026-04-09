const request = () => {
  return {} // fixme
}

module.exports = {
  cnn: {
    rss: {
      cnn_topstories: () => request(`http://rss.cnn.com/rss/cnn_topstories.rss`),
    }
  },
}
