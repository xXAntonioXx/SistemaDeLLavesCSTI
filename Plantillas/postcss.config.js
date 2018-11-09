module.exports = {
  plugins: [
    require('postcss-cssnext')({
      features: {
        autoprefixer: {
          grid: true,
          flexbox: true,
          boxshadow: true,
          subgrid: true,
        },
      customProperties: true,
      }
    })
  ]
}