require('rspec')
require('pry')
require('pg')
require('student')
require('department')
require('course')

DB = PG.connect({:dbname=>"registrar_test"})

RSpec.configure do |config|
    config.after(:each) do
    DB.exec("DELETE FROM courses *;")
    DB.exec("DELETE FROM students *;")
    DB.exec("DELETE FROM departments *;")
  end
end
