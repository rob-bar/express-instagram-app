https = require('https')
exports.instagram =
	all: (req, resi) ->
		data = []
		options =
			host: 'api.instagram.com'
			path: '/v1/users/9205448/media/recent/?access_token=9205448.ab103e5.40f43201df12427bb276eff4d2ca7348'
			method: "GET"
			headers:
				'Content-Type': 'application/json'

		request = https.request options, (res)->
			data = []

			res.on 'data', (chunk)->
				console.log chunk
				data.push(chunk)

			res.on 'error', (e)->
				console.log "Got error: #{e.message}"

			res.on 'end', ()->
				data = JSON.parse data.join('')

				for prop in data.data
					console.log prop
				resi.render "all", pics: data.data, title: "all pics"

		request.end()

		@