https = require('https')
http = require('http')
exports.help =
	securerequest: (options, callback) ->
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

	request: (options, callback) ->
		request = http.request options, (res)->
			data = []

			res.on 'data', (chunk)->
				data.push(chunk)

			res.on 'error', (e)->
				console.log "Got error: #{e.message}"

			res.on 'end', ()->
				data = JSON.parse data.join('')
				callback(data)
		request.end()