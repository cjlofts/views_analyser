require 'set'
class Parser
  FileFormatError = Class.new(StandardError)

  def initialize(file_path)
    @file_path = file_path
    @page_views = {}
  end

  def parse
    open_and_parse_file
    @page_views
  end

  private

  def open_and_parse_file
    File.open(@file_path, 'r') do |f|
      f.each do |line|
        record_page_view(line)
      end
    end
  end

  def record_page_view(line)
    split_line = line.split(' ')
    raise FileFormatError.new(line) if invalid_line_item?(split_line)

    if @page_views[split_line.first].nil?
      set_initial_values(split_line)
    else
      increment_values(split_line)
    end
  end

  def set_initial_values(split_line)
    @page_views[split_line.first] = {}
    @page_views[split_line.first]['count'] = 1
    @page_views[split_line.first]['unique_ips'] = Set.new([split_line.last])
  end

  def increment_values(split_line)
    @page_views[split_line.first]['count'] += 1
    @page_views[split_line.first]['unique_ips'].add(split_line.last)
  end

  def invalid_line_item?(split_line)
    # If the format of the log file has changed, we want to know about it or we
    # will begin to get spurious results and it will be hard to trace.
    split_line.length != 2 || !split_line.last.include?('.')
  end
end
