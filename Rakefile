require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "e4u-emoji"
    gem.summary = %Q{Emoji implementation using E4U}
    gem.description = %Q{Emoji implementation using E4U}
    gem.email = "fistfvck@gmail.com"
    gem.homepage = "http://github.com/fistfvck/e4u-emoji"
    gem.authors = ["fistfvck"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "e4u"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "e4u-emoji #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'table_maker'
task :data => ['lib/e4u/emoji/docomo.rb',
               'lib/e4u/emoji/kddi.rb',
               'lib/e4u/emoji/softbank.rb',
               'lib/e4u/emoji/google.rb',]

file 'lib/e4u/emoji/docomo.rb' do
  make_emoji_table 'lib/e4u/emoji/docomo.rb', :docomo, 'DOCOMO_TABLE'
end

file 'lib/e4u/emoji/kddi.rb' do
  make_emoji_table 'lib/e4u/emoji/kddi.rb', :kddi, 'KDDI_TABLE'
end

file 'lib/e4u/emoji/softbank.rb' do
  make_emoji_table 'lib/e4u/emoji/softbank.rb', :softbank, 'SOFTBANK_TABLE'
end

file 'lib/e4u/emoji/google.rb' do
  make_emoji_table 'lib/e4u/emoji/google.rb', :google, 'GOOGLE_TABLE'
end
