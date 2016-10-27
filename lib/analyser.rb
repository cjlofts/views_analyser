require_relative 'parser'
class Analyser

  def initialize(file_path)
    @file_path = file_path
  end

  def page_views
    parsed_data = parse_file

    sort_by_count(parsed_data).each do |k, v|
      puts "#{k} #{v['count']} visits"
    end
    :page_views_descending
  end

  def unique_views
    parsed_data = parse_file

    sort_by_unique(parsed_data).each do |k, v|
      puts "#{k} #{v['unique_ips'].count} unique views"
    end
    :unique_views_descending
  end

  private

  def parse_file
    Parser.new(@file_path).parse
  end

  def sort_by_count(data)
    Hash[data.sort_by { |_, v| v['count'] }.reverse]
  end

  def sort_by_unique(data)
    Hash[data.sort_by { |_, v| v['unique_ips'].count }.reverse]
  end
end
