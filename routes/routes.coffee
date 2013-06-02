config = require('../config/config.coffee')
h = require('../config/helper.coffee')
_ = require('underscore')
exports.instagram =
	all: (req, res) ->
		options =
			host: 'api.instagram.com'
			path: "/v1/users/#{config.site.instagram.ID}/media/recent/?access_token=#{config.site.instagram.token}&count=-1"
			method: "GET"
			headers:
				'Content-Type': 'application/json'

		h.help.securerequest options, (data)->
			res.render "all", pics: data.data, title: "all pics"

		@
	tag: (req, res) ->
		options =
			host: 'api.instagram.com'
			path: "/v1/tags/#{req.params.tag}/media/recent/?access_token=#{config.site.instagram.token}"
			method: "GET"
			headers:
				'Content-Type': 'application/json'

		h.help.securerequest options, (data)->
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

		h.help.securerequest options, (data)->
			res.render "repos", repos: data, title: "all github repos"
		@

exports.twitter =
	all: (req, res) ->
		options =
			host: "api.twitter.com"
			path: "/1/statuses/user_timeline.json?include_entities=true&include_rts=1&screen_name=#{config.site.twitter.screenname}&count=200"
			method: "GET"
			headers:
				'Content-Type': 'application/json'
				'user-agent': req.get('user-agent')

		h.help.securerequest options, (data)->
			res.render "tweets", tweets: data, title: "all my tweets"
		@

	tag: (req, res) ->
		options =
			host: "api.twitter.com"
			path: "/1/statuses/user_timeline.json?include_entities=true&include_rts=1&screen_name=#{config.site.twitter.screenname}&count=200"
			method: "GET"
			headers:
				'Content-Type': 'application/json'
				'user-agent': req.get('user-agent')

		h.help.securerequest options, (data)->
			data = _.filter data, (tweet) ->
				for hashtag in tweet.entities.hashtags
					if hashtag.text is req.params.tag
						return true
				return false

			res.render "tweetsbytag", tweets: data, title: "all my tweets by tag", tag: req.params.tag
		@

exports.delicious =
	all: (req, res) ->
		options =
			host: "feeds.delicious.com"
			path: "/v2/json/#{config.site.deli.username}?count=100"
			method: "GET"
			headers:
				'Content-Type': 'application/json'
				'user-agent': req.get('user-agent')

		h.help.request options, (data)->
			console.log data
			res.render "deli", links: data, title: "all my links"
		@

	tag: (req, res) ->
		options =
			host: "feeds.delicious.com"
			path: "/v2/json/#{config.site.deli.username}/#{req.params.tag}?count=100"
			method: "GET"
			headers:
				'Content-Type': 'application/json'
				'user-agent': req.get('user-agent')

		h.help.request options, (data)->
			res.render "delibytag", links: data, title: "all my links by tag", tag: req.params.tag
		@

exports.other =
	index: (req, res) ->
		console.log _
		res.render "index", title: "Social api testing in node"
		@