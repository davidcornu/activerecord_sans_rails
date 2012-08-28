# encoding=utf-8
require 'logger'
require 'rubygems'
require 'bundler/setup'
require 'active_record'

APP_DIR = File.expand_path File.dirname(__FILE__)

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql2',
  :database => 'datababse',
  :username => 'root',
  :password => '',
  :host     => '127.0.0.1'
)
