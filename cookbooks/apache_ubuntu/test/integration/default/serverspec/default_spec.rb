require 'spec_helper'


describe package('apache2') do
  it { should be_installed }
end

describe service('apache2') do
	it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe file('/var/www/html/index.html') do
  it { should contain 'Hello' }
end