#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

$: << File.dirname(__FILE__)
require 'date'
require 'lib/google_analytics'

GoogleAnalytics.new.sources
