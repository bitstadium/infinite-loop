command :'devices:list' do |c|
  c.syntax = 'hockey devices:list'
  c.summary = 'Lists the Devices of an App on HockeyApp'
  c.description = ''

  c.action do |args, options|
    say_error "Missing arguments, expected App ID" and abort if args.nil? or args.empty?

    devices = try { agent.list_devices(args[0], (args.length > 1 ? args[1] : nil)) }
    title = "Listing Devices"
    table = Terminal::Table.new :title => title do |t|
      t << ["Device Name", "Device Identifier"]
      t.add_separator
      devices.compact.each do |device|
        t << [
          device["name"],
          device["udid"]
        ]
      end
      puts t
    end
  end
end

command :'devices:loop' do |c|
  c.syntax = 'hockey devices:list'
  c.summary = 'Add the Devices of an App on HockeyApp to the Provisioning Portal'
  c.description = ''

  c.action do |args, options|
    say_error "Missing arguments, expected App ID" and abort if args.nil? or args.empty?

    devices = try { agent.list_devices(args[0], (args.length > 1 ? args[1] : nil)) }
    title = "Listing Devices"
    table = Terminal::Table.new :title => title do |t|
      t << ["#", "Device Name", "Device Identifier"]
      t.add_separator
      index = 0
      devices.compact.each do |device|
        t << [
          "#{index + 1}",
          device["name"],
          device["udid"]
        ]
        index += 1
      end

      looping = true
      while looping
        puts t
        selected = ask "Add device by #, or all devices (a), or quit (q):"
        puts

        case selected
        when 'q'
          add = nil
          looping = false
        when 'a'
          add = devices
        else
          add = [devices[selected.to_i - 1]] if selected.to_i >= 1 and selected.to_i <= index
        end

        unless add.nil?
          ext_args = []
          add.each do |device|
            ext_args << "\"#{device["name"]}=#{device["udid"]}\""
          end
          system "ios devices:add #{ext_args.join(" ")}"
        end
      end
    end
  end
end
