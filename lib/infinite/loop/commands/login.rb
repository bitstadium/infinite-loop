command :login do |c|
  c.syntax = 'hockey login'
  c.summary = 'Sign in to HockeyApp and fetch or create token'
  c.description = ''

  c.action do |args, options|
    say_warning "You are already authenticated" if Netrc.read[Infinite::HOSTNAME]

    user = ask "Email:"
    pass = password "Password:"

    tokens = agent.list_tokens(user, pass)
    tokens.reject! { |token| token["rights"].to_i != 2 }
    if tokens.length == 0
      tokens = agent.create_token(user, pass)
    end

    netrc = Netrc.read
    netrc[Infinite::HOSTNAME] = tokens.first["token"], "X"
    netrc.save

    say_ok "API token saved"
  end
end
