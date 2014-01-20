# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, version: 2, bundler: true, focus_on_failed: true, cli: '-c -f doc' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
end
