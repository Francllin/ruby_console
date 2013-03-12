# encoding: utf-8
=begin
Run with:
pry -r ./console.rb

Based on simple_test.rb
https://github.com/appium/appium/blob/82995f47408530c80c3376f4e07a1f649d96ba22/sample-code/examples/ruby/simple_test.rb
https://github.com/appium/appium/blob/c58eeb66f2d6fa3b9a89d188a2e657cca7cb300f/LICENSE
=end

require 'selenium-webdriver'

# Path to the .app or .app.zip.
# The path can be local or remote for Sauce.
APP_PATH = ENV['APP_PATH'] unless defined?(APP_PATH)

# The name to use for the test run on Sauce.
APP_NAME = ENV['APP_NAME'] unless defined?(APP_NAME)

# Android app package
APP_PACKAGE = ENV['APP_PACKAGE'] unless defined?(APP_PACKAGE)

# Android app starting activity.
APP_ACTIVITY = ENV['APP_ACTIVITY'] unless defined?(APP_ACTIVITY)

# Sauce Username
SAUCE_USERNAME = ENV['SAUCE_USERNAME'] unless defined?(SAUCE_USERNAME)

# Sauce Key
SAUCE_ACCESS_KEY = ENV['SAUCE_ACCESS_KEY'] unless defined?(SAUCE_ACCESS_KEY)

PORT = ENV['PORT'] || 4723 unless defined?(PORT)

$os = nil

if $os.nil?
  $os = :ios
  $os = :android if APP_PATH.end_with?('.apk') || APP_PATH.end_with?('.apk.zip')
end

puts "OS is: #{$os}" if defined?(Pry)

# ruby_console files load depending on OS
require 'helper'
require 'button'
require 'text'
require 'window'
require 'patch'
require 'alert'

# Android combines secure and textfield.
# iOS differentiates between secure and textfield.
# combine secure & textfield on iOS to match Android behavior.
$os == :ios ? require('ios/textfield') :
              require('android/textfield')

# WebDriver capabilities. Must be valid for Sauce to work.
# https://github.com/jlipps/appium/blob/master/app/android.js
def android_capabilities
  {
    browserName: 'Android',
    platform: 'LINUX',
    version: '4.1',
    device: 'Android',
    name: APP_NAME || 'Ruby Console Android Appium',
    app: absolute_app_path,
    :'app-package' => APP_PACKAGE,
    :'app-activity' => APP_ACTIVITY
  }
end

# WebDriver capabilities. Must be valid for Sauce to work.
def ios_capabilities
  {
    browserName: 'iOS 6.0',
    platform: 'Mac 10.8',
    version: '6.0',
    device: 'iPhone Simulator',
    name: APP_NAME || 'Ruby Console iOS Appium',
    app: absolute_app_path
  }
end

def capabilities
  $os == :ios ? ios_capabilities : android_capabilities
end

# Converts environment variable APP_PATH to an absolute path.
# @return [String] APP_PATH as an absolute path
def absolute_app_path
    raise 'APP_PATH environment variable not set!' if APP_PATH.nil?
    return APP_PATH if APP_PATH.match(/^http/) # public URL for Sauce
    return APP_PATH if APP_PATH.match(/^\//) # absolute file path
    file = File.join(File.dirname(__FILE__), APP_PATH)
    raise "App doesn't exist #{file}" unless File.exist? file
    file
end

# Get the server url for sauce or local based on env vars.
# @return [String] the server url
def server_url
  if !SAUCE_USERNAME.nil? && !SAUCE_ACCESS_KEY.nil?
    "http://#{SAUCE_USERNAME}:#{SAUCE_ACCESS_KEY}@ondemand.saucelabs.com:80/wd/hub"
  else
    "http://127.0.0.1:#{PORT}/wd/hub"
  end
end

# Quits the driver
# @return [void]
def driver_quit
  # rescue NoSuchDriverError
  begin; $driver.quit unless $driver.nil?; rescue; end
end

# Creates a new global driver and quits the old one if it exists.
# @return [Selenium::WebDriver] the new global driver
def start_driver
  @client = @client || Selenium::WebDriver::Remote::Http::Default.new
  @client.timeout = 999999

  # If the driver already exists, quit before creating a new driver.
  driver_quit

  begin
    $driver = Selenium::WebDriver.for(:remote, http_client: @client, desired_capabilities: capabilities, url: server_url)
  rescue Errno::ECONNREFUSED
    puts 'ERROR: Unable to connect to Appium. Is the server running?'
    exit
  end

  # Set timeout to a large number so that Appium doesn't quit
  # when no commands are entered after 60 seconds.
  $driver.execute_script 'mobile: setCommandTimeout', timeout: 9999

  # Must set implicit_wait to zero or $ commands will fail.
  # execute_script "$('button')"
  # $ commands fail anyway now so set implicit wait.
  # https://github.com/appium/appium/issues/214
  $driver.manage.timeouts.implicit_wait = 30

  $driver
end

# Setup driver
start_driver if $driver.nil?

# Set implicit wait to zero.
def no_wait
  $driver.manage.timeouts.implicit_wait = 0
end

# The same as $driver.execute_script
# @return the object returned by execute_script
def execute_script script, *args
  $driver.execute_script script, *args
end

# Quit the driver and Pry.
# quit and exit are reserved by Pry.
def x
  driver_quit
  exit # exit pry
end

# Paging in Pry is annoying :q required to exit.
# With pager disabled, the output is similar to IRB
# Only set if Pry is defined.
Pry.config.pager = false if defined?(Pry)
