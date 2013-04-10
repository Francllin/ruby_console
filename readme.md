#### Ruby Console for Appium [![Dependency Status](https://gemnasium.com/appium/ruby_console.png)](https://gemnasium.com/appium/ruby_console)

- [appium_console on RubyGems](https://rubygems.org/gems/appium_console)

#### Update system

Paste the following into Terminal. If you're not using [RVM](https://rvm.io/), you may have to prefix gem commands with sudo.

```bash
gem update --system ;\
gem update bundler
```

#### Install / Upgrade Ruby Console

```bash
gem uninstall -aIx appium_lib ;\
gem uninstall -aIx appium_console ;\
gem install --no-rdoc --no-ri appium_console
```

#### Update Appium

To update `appium` from source (assuming node.js requires sudo):

Clone appium if you haven't already.

`git clone git@github.com:appium/appium.git`

then in the `appium` folder:

```bash
git pull ;\
sudo ./reset.sh ; ./reset.sh
```

You should uninstall the `ap` gem because it breaks awesome_print.

`gem uninstall -aIx ap`

#### Run

The `arc` command starts Appium Ruby Console.

`arc -v` will print the current version of appium console and appium lib.

Ruby 1.9.3 and Appium from GitHub are required. Run Appium from source.

`node server.js -V --fast-reset`

For OS X, export the path to your .app bundle `MyApp.app` or zipped app bundle `MyApp.app.zip`

`export APP_PATH="../MyApp.app"`

For Android:

`APP_ACTIVITY` is the activity to start the app with.
`APP_WAIT_ACTIVITY` is the activity to wait for before considering the app as having been started.

```
export APP_PATH="/path/to/my.apk" ;\
export APP_PACKAGE="com.my.Pkg" ;\
export APP_ACTIVITY="StartActivity" ;\
export APP_WAIT_ACTIVITY="SplashActivity"
```

You may want to define the environment variables in `~/.bash_profile` so you don't have to export them again.

#### Reset Appium

Reset Appium after pulling the latest changes.

`$ ./reset.sh`

#### Documentation

See [docs.md](https://github.com/appium/ruby_lib/blob/master/docs.md)
