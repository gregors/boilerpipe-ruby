desc 'Run code quality check'
task :cane do
  require 'cane/cli'

  file_path = '.cane'

  canefile = Cane::CLI::Parser.new
  canefile.parser.parse! canefile.read_options_from_file(file_path)

  options = canefile.options.merge(
    :max_violations => 0,
  )

  Cane.run(options)
end
