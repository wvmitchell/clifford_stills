require './test/test_helper.rb'
require 'bundler'
Bundler.require
require 'rack/test'
require 'capybara'
require 'capybara/dsl'

require './lib/app'

Capybara.app = ClyffordStillsApp

Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, :headers => {'User-Agent' => 'Capybara'})
end

class ClyffordManagementTest < Minitest::Test
  include Capybara::DSL

  attr_reader :p_db, :h_db

  def setup
    @p_db = Database::Programs.db_connection
    @h_db = Database::Hours.db_connection
    Database::Hours.create_table_if_none
    Database::Programs.create_table_if_none
  end

  def teardown
    h_db.drop_table(:hours)
    p_db.drop_table(:programs)
  end

  def test_hours_are_updated_by_admin
    visit '/admin/hours'
    assert page.has_content?('Monday')

    select 'Monday', :from => 'day'
    select '8', :from => 'opens_at'
    select '16', :from => 'closes_at'
    click_button 'Update Hours'

    visit '/hours'
    assert page.has_content?('Monday: 8 a.m. - 4 p.m.')
  end

  def test_programs_are_updated_by_admin
    visit '/admin/programs'
    assert page.has_content?('Instructor')

    fill_in 'program[name]', :with => 'Pasta'
    fill_in 'program[description]', :with => 'Making Pasta'
    fill_in 'program[instructor]', :with => 'Emeril'
    #select '01/01/2000', :from => 'start_date'
    #select '01/02/2000', :from => 'end_date'
    select '17', :from => 'program[hour]'
    select 'Member', :from => 'program[type]'
    click_button 'Update Programs'

    visit '/programs'
    assert page.has_content?('Pasta')
    assert page.has_content?('Making Pasta')
    assert page.has_content?('5 p.m.')
  end

end

