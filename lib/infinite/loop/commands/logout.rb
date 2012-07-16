command :logout do |c|
  c.syntax = 'hockey logout'
  c.summary = 'Remove API token'
  c.description = ''

  c.action do |args, options|
    say_error "You are not authenticated" and abort unless Netrc.read[Infinite::HOSTNAME]

    netrc = Netrc.read
    netrc.delete(Infinite::HOSTNAME)
    netrc.save

    say_ok "API token removed"
  end
end
