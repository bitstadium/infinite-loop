command :'apps:list' do |c|
  c.syntax = 'hockey apps:list'
  c.summary = 'Lists the Name and ID of Apps on HockeyApp'
  c.description = ''

  c.action do |args, options|
    if args.nil? or args.empty?
      apps = try { agent.list_apps }
    else
      apps = try { agent.list_apps(args.first) }
    end

    title = "Listing Apps"
    table = Terminal::Table.new :title => title do |t|
      t << ["Title", "Platform", "Release Type", "App ID"]
      t.add_separator
      apps.compact.each do |app|
        t << [
          app["title"], 
          app["platform"], 
          agent.release_type_string(app["release_type"]),
          app["public_identifier"]
        ]
      end
      puts t
    end
  end
end