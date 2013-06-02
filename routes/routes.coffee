config = require('../config/config.coffee')
h = require('../config/helper.coffee')
exports.instagram =
	all: (req, res) ->
		options =
			host: 'api.instagram.com'
			path: "/v1/users/#{config.site.instagram.ID}/media/recent/?access_token=#{config.site.instagram.token}&count=-1"
			method: "GET"
			headers:
				'Content-Type': 'application/json'

		h.help.request options, (data)->
			res.render "all", pics: data.data, title: "all pics"

		@
	tag: (req, res) ->
		options =
			host: 'api.instagram.com'
			path: "/v1/tags/#{req.params.tag}/media/recent/?access_token=#{config.site.instagram.token}"
			method: "GET"
			headers:
				'Content-Type': 'application/json'

		h.help.request options, (data)->
			res.render "tag", pics: data.data, title: "all pics", tag: req.params.tag

		@

exports.github =
	all: (req, res) ->
		options =
			host: 'api.github.com'
			path: "/users/#{config.site.github.username}/repos?sort=created"
			method: "GET"
			headers:
				'Content-Type': 'application/json'
				'user-agent': req.get('user-agent')

		h.help.request options, (data)->
			console.log data
			res.render "repos", repos: data, title: "all github repos"
		@

exports.other =
	index: (req, res) ->
		res.render "index", title: "Social api testing in node"
		@