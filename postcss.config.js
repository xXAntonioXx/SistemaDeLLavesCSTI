module.exports = {
  plugins: [
    require('postcss-import')({
      plugins: [
        require('stylelint'),
      ]
    }),
    require('postcss-font-magician')({
      variants: {
        'Hind':{
          '300': [],
          '400': [],
        },
        'Montserrat': {
          '400': [],
          '500': [],
        }
      }
    }),
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
    }),
    require('css-mqpacker'),
    require('cssnano')
  ]
}