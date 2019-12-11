" Set ruby path to be the rbenv shims directory
let g:ruby_path = system('echo $HOME/.rbenv/shims')

" Set bundle as the command to run rubocop
let g:ale_ruby_rubocop_executable = 'bundle'
