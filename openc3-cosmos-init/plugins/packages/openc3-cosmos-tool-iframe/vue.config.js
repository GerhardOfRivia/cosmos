module.exports = {
  publicPath: '/tools/iframe',
  outputDir: 'tools/iframe',
  filenameHashing: false,
  transpileDependencies: ['vuetify'],
  devServer: {
    port: 2915,
    headers: {
      'Access-Control-Allow-Origin': '*',
    },
    client: {
      webSocketURL: {
        hostname: 'localhost',
        pathname: '/tools/iframe',
        port: 2915,
      },
    },
  },
  configureWebpack: {
    output: {
      libraryTarget: 'system',
    },
  },
  chainWebpack(config) {
    config.module
      .rule('js')
      .use('babel-loader')
      .tap((options) => {
        return {
          rootMode: 'upward',
        }
      })
    config.module
      .rule('vue')
      .use('vue-loader')
      .tap((options) => {
        return {
          prettify: false,
        }
      })
    config.externals(['vue', 'vuetify', 'vuex', 'vue-router'])
  },
}
