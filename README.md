# ViewsAnalyser

A basic ruby script to parse a log file and output the total views and unique
views to web pages.

## Installation

Clone the repo then:

    $ bundle

to install dependencies

## Usage

Easiest way:

```ruby
pry
```

then:

```ruby
load './lib/analyser.rb'
```

Instantiate an instance of the class:

```ruby
instance = Analyser.new('/Users/my_log_file/server.log')
```

Print out a list of total page views in descending order:

```ruby
instance.page_views
```

Print out a list of unique page views in descending order:

```ruby
instance.unique_views
```

Exit pry when finished 
