c = require('../config/config.coffee')
h = require('../config/helper.coffee')
exports.instagram =
	all: (req, res) ->
		data = []
		options =
			host: 'api.instagram.com'
			path: "/v1/users/#{c.config.instagram.ID}/media/recent/?access_token=#{c.config.instagram.token}"
			method: "GET"
			headers:
				'Content-Type': 'application/json'

		h.help.request options, (data)->
			res.render "all", pics: data.data, title: "all pics"

		@
	tag: (req, res) ->
		data = []

		options =
			host: 'api.instagram.com'
			path: "/v1/tags/#{req.params.tag}/media/recent/?access_token=#{c.config.instagram.token}"
			method: "GET"
			headers:
				'Content-Type': 'application/json'

		h.help.request options, (data)->
			res.render "all", pics: data.data, title: "all pics"

		@