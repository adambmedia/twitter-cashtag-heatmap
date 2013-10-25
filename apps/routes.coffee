
routes = (app) ->
  app.get '/', (req, res) ->
    res.render 'index', {
      data: app.settings.watchList
    }

module.exports = routes