# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :visual do
  guard 'livereload' do
    watch(%r{app/.+\.(erb|haml)$})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{(public/|app/assets).+\.(css|js|html)})
    watch(%r{(app/assets/.+\.css)\.scss}) { |m| m[1] }
    watch(%r{(app/assets/.+\.js)\.coffee}) { |m| m[1] }
    watch(%r{config/locales/.+\.yml})
  end

  ## Sample template for guard-unicorn
  #
  # Usage:
  #     guard :unicorn, <options hash>
  #
  # Possible options:
  # * :daemonize (default is true) - should the Unicorn server start daemonized?
  # * :config_file (default is "config/unicorn.rb") - the path to the unicorn file
  # * :pid_file (default is "tmp/pids/unicorn.pid") - the path to the unicorn pid file
  guard :unicorn, :daemonize => true
end

group :ci do
#  guard 'spin' do
#    # uses the .rspec file
#    # --colour --fail-fast --format documentation --tag ~slow
#    watch(%r{^spec/.+_spec\.rb$})
#    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
#    watch(%r{^app/(.+)\.haml$})                         { |m| "spec/#{m[1]}.haml_spec.rb" }
#    watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
#    watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/requests/#{m[1]}_spec.rb"] }
#    watch('config/routes.rb')                           { "spec/routing/*_routing_spec.rb" }
#
#    # Capybara request specs
#    watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
#    # Factory Girl
#    watch(%r{^spec/factories/(.+)\.rb$})                { |m| "spec/models/#{m[1]}_spec.rb" }
#  end

  # Note: The cmd option is now required due to the increasing number of ways
  #       rspec may be run, below are examples of the most common uses.
  #  * bundler: 'bundle exec rspec'
  #  * bundler binstubs: 'bin/rspec'
  #  * spring: 'bin/rsspec' (This will use spring if running and you have
  #                          installed the spring binstubs per the docs)
  #  * zeus: 'zeus rspec' (requires the server to be started separetly)
  #  * 'just' rspec: 'rspec'
  guard :rspec, cmd: 'bundle exec rspec',
                failed_mode: :keep,
                all_after_pass: true,
                all_on_start: true            do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')  { "spec" }

    # Rails example
    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml|\.jbuilder)$})      { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
    watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
    watch('config/routes.rb')                           { "spec/routing" }
    watch('app/controllers/application_controller.rb')  { "spec/controllers" }
    watch('spec/rails_helper.rb')                       { "spec" }

    # Factories
    watch(%r{^spec/factories/(.+)\.rb$})                  { "spec" }

    # Capybara features specs
    watch(%r{^app/views/(.+)/.*\.(erb|haml|jbuilder)$}) { |m| "spec/features/#{m[1]}_spec.rb" }

    # Turnip features and steps
    watch(%r{^spec/acceptance/(.+)\.feature$})
    watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
  end
end
