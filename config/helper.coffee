https = require('https')
exports.help =
	request: (options, callback) ->
		request = https.request options, (res)->
			data = []

			res.on 'data', (chunk)->
				data.push(chunk)

			res.on 'error', (e)->
				console.log "Got error: #{e.message}"

			res.on 'end', ()->
				data = JSON.parse data.join('')
				callback(data)

		request.end()