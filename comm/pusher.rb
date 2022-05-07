$pusher = Pusher::Client.new(
  app_id: '995167',
  key: ENV['PUSHER_KEY'],
  secret: ENV['PUSHER_SECRET'],
  cluster: 'us2',
  encrypted: true
)

#$pusher.trigger('my-channel', 'my-event', {message: 'hello world'})