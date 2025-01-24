require "file_utils"
require "path"
require "time"

begin
  # Check if .aixtract file exists
  unless File.exists?(".aixtract")
    puts ".aixtract file not found in current directory"
    exit(1)
  end

  # Get the project name from the current directory
  project_name = Path[Dir.current].basename

  # Create target directory with timestamp
  timestamp = Time.local.to_s("%Y%m%d%H%M%S")
  target_dir = Path[Dir.tempdir]/"#{project_name}_#{timestamp}"
  Dir.mkdir_p(target_dir)

  # Read .aixtract file
  File.each_line(".aixtract") do |filepath|
    # Skip empty lines and comments
    filepath = filepath.strip
    next if filepath.empty? || filepath.starts_with?("#")

    # Normalize filepath
    filepath = Path[filepath].normalize

    # Check if file exists
    unless File.exists?(filepath)
      puts "Warning: File not found: #{filepath}"
      next
    end

    begin
      # Convert path separators to double underscores
      new_filename = filepath.to_posix.to_s.gsub("/", "__")
      # Copy the file to the target directory with the new name
      FileUtils.cp(filepath, Path[target_dir]/new_filename)
      puts "Copied: #{filepath} -> #{new_filename}"
    rescue ex
      puts "Error processing #{filepath}: #{ex.message}"
    end
  end

  puts "\nFiles extracted to: #{target_dir}"

  # Open the target directory
  {% if flag?(:darwin) %}
    Process.run("open", [target_dir.to_s])
  {% elsif flag?(:linux) %}
    Process.run("xdg-open", [target_dir.to_s])
  {% end %}
rescue ex
  puts "Error: #{ex.message}"
  exit(1)
end
