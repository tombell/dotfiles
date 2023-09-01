#!/usr/bin/ruby

require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 50
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

Reline.autocompletion = IRB.conf[:USE_AUTOCOMPLETE] = false if defined?(Reline) && Reline.respond_to?(:autocompletion=)
