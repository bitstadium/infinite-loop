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
$ hockey devices:list
```

If you only want devices which are not in your current provisioning profile, add "unprovisioned":

```sh
$ hockey devices:list unprovisioned
```

### Loop of Devices and Add to Provisioning Portal

This works only if you have already set up cupertino:

```sh
$ gem install infinite-loop
$ ios login
```

Then you can show all device (or all unprovisioned devices, see above) and add them to the portal:

```sh
$ hockey devices:loop
```

Finally edit your profile:

```sh
$ ios profiles:manage:devices distribution
```

## TODO

- Download profiles from the Provisioning Portal
- Upload modified profiles to HockeyApp

## Contact

Thomas Dohmke & HockeyApp

- http://twitter.com/ashtom
- http://twitter.com/hockeyapp
- support@hockeyapp.net

## License

Infinite Loop is available under the MIT license. See the LICENSE file for more info.