process.env.NODE_ENV = process.env.NODE_ENV || 'beta'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()
