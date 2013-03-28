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

- find_elements returns an empty array [] when no elements are found.

##### [app_lib on rubydoc.info](http://www.rubydoc.info/github/appium/ruby_lib/master/toplevel)

- [iOS UI Automation](http://developer.apple.com/library/ios/#documentation/DeveloperTools/Reference/UIAutomationRef/_index.html) Example use `@driver.execute_script "UIATarget.localTarget().frontMostApp().mainWindow().rect()"
`
- [Android UIAutomator](http://developer.android.com/tools/help/uiautomator/index.html)
- [Ruby selenium-webdriver](http://selenium.googlecode.com/svn/trunk/docs/api/rb/index.html)
- [Appium](https://github.com/appium/appium/blob/master/README.md)
- [Appium extension](https://github.com/appium/appium/wiki/Automating-mobile-gestures)
- [mechanic names of elements](https://github.com/jaykz52/mechanic/blob/8c490e1d225f384847e47ffdafb47cc2248bb96c/src/mechanic-core.js#L28)
- [All methods supported by Appium](https://github.com/appium/appium/wiki/JSON-Wire-Protocol:-Supported-Methods)
- [Appium's mobile gesture docs](https://github.com/appium/appium/wiki/Automating-mobile-gestures)
- 
Example use of Appium's mobile gesture.

> @driver.execute_script 'mobile: tap', :x => 0, :y => 500

`console.rb` uses some code from [simple_test.rb](
https://github.com/appium/appium/blob/82995f47408530c80c3376f4e07a1f649d96ba22/sample-code/examples/ruby/simple_test.rb) and is released under the [same license](https://github.com/appium/appium/blob/c58eeb66f2d6fa3b9a89d188a2e657cca7cb300f/LICENSE) as Appium. The [Accessibility Inspector](https://developer.apple.com/library/ios/#documentation/UserExperience/Conceptual/iPhoneAccessibility/Testing_Accessibility/Testing_Accessibility.html) is helpful for discovering button names and textfield values.

--

Tag Name  | UIA
       --:|:--
button    | UIAButton
textfield | UIATextField
secure    | UIASecureTextField
text      | UIAStaticText


--

- `source` Prints a JSON view of the current page.
- `(Element) name(name)` Returns the first element matching name. Android name is the content description.
iOS uses accessibility label with a fallback to text.
- `(Array<Element>) names(name)` Returns all elements matching name.
--

#### alert
0. `(void) alert_accept` Accept the alert.
0. `(String) alert_accept_text` Get the text of the alert's accept button.
0. `(void) alert_click(value)` iOS only Tap the alert button identified by value.
0. `(void) alert_dismiss` Dismiss the alert.
0. `(String) alert_dismiss_text` Get the text of the alert's dismiss button.
0. `(String) alert_text` Get the alert message text.

#### button
0. `(Button) button(index)` Find a button by index.
0. `(Button) button(text, number = 0)` Find a button by text and optionally number.
0. `(Button) button_include(text)` Get the first button that includes text.
0. `(Array<String>, Array<Buttons>) buttons(text = nil)` Get an array of button texts or button elements if text is provided.
0. `(Array<Button>) buttons_include(text)` Get all buttons that include text.
0. `(Button) first_button` Get the first button element.
0. `(Button) last_button` Get the last button element.

#### textfield
0. `(Textfield) textfield(index)` Find a textfield by index.
0. `(Array<Textfield>) e_textfields` Get an array of textfield elements.
0. `(Textfield) first_textfield` Get the first textfield element.
0. `(Textfield) last_textfield` Get the last textfield element.
0. `(Textfield) textfield(text)` Get the first textfield that matches text.
0. `(Textfield) textfield_include(text)` Get the first textfield that includes text.
0. `(Array<String>) textfields` Get an array of textfield texts.

#### text
0. `(Text) text(index)` Find a text by index.
0. `(Array<Text>) e_texts` Get an array of text elements.
0. `(Text) first_text` Get the first text element.
0. `(Text) last_text` Get the last text element.
0. `(Text) text(text)` Get the first element that matches text.
0. `(Text) text_include(text)` Get the first textfield that includes text.
0. `(Array<String>) texts` Get an array of text texts.

#### window
0. `(Object) window_size` Get the window's size.

--

```ruby
e.name # button, text
e.value # secure, textfield
e.type
e.tag_name # calls .type (patch.rb)
e.text
e.size
e.location
e.rel_location
e.click
e.send_keys 'keys to send'
e.set_value 'value to set' # ruby_console specific

# alert example without helper methods
alert = $driver.switch_to.alert
alert.text
alert.accept
alert.dismiss

# Secure textfield example.
#
# Find using default value
s = secure 'Password'
# Enter password
s.send_keys 'hello'
# Check value
s.value == password('hello'.length)
```

[routing.js](https://github.com/appium/appium/blob/master/app/routing.js#L69) lists not yet implemented end points.

--

#### Driver

`start_driver` will restart the driver.

`x` will quit the driver and exit Pry.

`execute_script` calls `$driver.execute_script`

`find_element` calls `$driver.find_element`

`find_elements` calls `$driver.find_elements`

`mobile :swipe, endX: 100, endY: 100, duration: 0.01` calls `$driver.execute_script 'mobile: swipe', endX: 100, endY: 100, duration: 0.01`

`no_wait` will set implicit wait to 0. `$driver.manage.timeouts.implicit_wait = 0`

`set_wait` will set implicit wait to default 30 seconds. `$driver.manage.timeouts.implicit_wait = 30`

`set_wait(timeout_seconds)` will set implicit wait to desired timeout. `$driver.manage.timeouts.implicit_wait = timeout`

.click to tap an element.
.send_keys to type on an element.

#### Raw UIAutomation

`execute_script "au.lookup('button')[0].tap()"` is the same as
`execute_script 'UIATarget.localTarget().frontMostApp().buttons()[0].tap()'`

See [app.js](https://github.com/appium/appium/blob/master/app/uiauto/appium/app.js#L3) for more au methods.
Note that raw UIAutomation commands are not offically supported.

Advanced au.

In this example we lookup two tags, combine the results, wrap with $, and then return the elements.

```ruby
s = %(
var t = au.lookup('textfield');
var s = au.lookup('secure');
var r = $(t.concat(s));
au._returnElems(r);
)

execute_script s
```

#### XPath

See [#194](https://github.com/appium/appium/pull/194/files) for details.

```ruby
find_element  :xpath, 'button'
find_elements :xpath, 'button'

find_element  :xpath, 'button[@name="Sign In"]'
find_elements :xpath, 'button[@name="Sign In"]'

find_element  :xpath, 'button[contains(@name, "Sign In")]'
find_elements :xpath, 'button[contains(@name, "Sign")]'

find_element :xpath, 'textfield[@value="Email"]'
find_element :xpath, 'textfield[contains(@value, "Email")]'

find_element  :xpath, 'text[contains(@name, "Reset")]'
find_elements :xpath, 'text[contains(@name, "agree")]'
```

#### Cucumber Sauce Integration

Reset after each test and when done report the result to Sauce after quiting the driver.

```ruby
require 'rest_client' # https://github.com/archiloque/rest-client
require 'json' # for .to_json

$passed = true

After do |scenario|
  $driver.execute_script 'mobile: reset'

  if $passed
    $passed = false if scenario.failed?
  end
end

at_exit do
  ID = $driver.send(:bridge).session_id
  $driver.quit
  
  if !SAUCE_USERNAME.nil? && !SAUCE_ACCESS_KEY.nil?
    URL = "https://#{SAUCE_USERNAME}:#{SAUCE_ACCESS_KEY}@saucelabs.com/rest/v1/#{SAUCE_USERNAME}/jobs/#{ID}"

    # Keep trying until passed is set correctly. Give up after 30 seconds.
    wait do
      response = RestClient.put URL, { 'passed' => $passed }.to_json, :content_type => :json, :accept => :json
      response = JSON.parse(response)

      # Check that the server responded with the right value.
      response['passed'] == $passed
    end
  end
end
```
