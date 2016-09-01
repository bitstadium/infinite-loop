# Infinite::Loop

### CLI for HockeyApp

List apps and devices from HockeyApp. Highly inspired by the great [Cupertino](https://github.com/mattt/cupertino).

## Installation

```sh
$ gem install infinite-loop
```

## Usage

### Fetch or Create an API token

```sh
$ hockey login
```

This asks you for your email and password. It then checks if you have any existing read-only tokens and stores the first in ~/.netrc. If not, it creates one.

### List of Apps

```sh
$ hockey apps:list
```

### List of Devices

```sh
$ hockey devices:list APP_ID
```

If you only want devices which are not in your current provisioning profile, add "unprovisioned":

```sh
$ hockey devices:list APP_ID unprovisioned
```

### Loop Over Devices and Add to Provisioning Portal

Option one: use cupertino

Here's how you set up cupertino:

```sh
$ gem install cupertino
$ ios login
```

Then you can show all device (or all unprovisioned devices, see above) and add them to the portal:

```sh
$ hockey devices:loop APP_ID
```

Finally edit your profile:

```sh
$ ios profiles:manage:devices distribution
```

Option two: If you're using fastlane

Add a lane to your Fastfile

```
  desc "Register Devices from Hockey"
  lane :register_devices do
    devices = `hockey devices:list ${HOCKEY_APP_ID} unprovisioned hash`
    register_devices(
      devices: eval(devices)
    )
    sigh(adhoc: true, force: true)
  end
```

Call fastlane like this:

```sh
$ fastlane register_devices HOCKEY_APP_ID=APP_ID

```

## TODO

- Download profiles from the Provisioning Portal
- Upload modified profiles to HockeyApp
- Token management
- Some error handling

## Contact

Thomas Dohmke & HockeyApp

- http://twitter.com/ashtom
- http://twitter.com/hockeyapp
- support@hockeyapp.net

## License

Infinite Loop is available under the MIT license. See the LICENSE file for more info.
