SearchYJ
====

Search on Yahoo Japan.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'searchyj'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install searchyj

## Usage (CLI)

The output format is generally JSON.

It has parameters the followings.

- uri
  - The URI of the web site。


- title
  - The title of the web site.
  - The title might be abbreviation.


- rank
  - The rank order in the search ranking.
  - This number might have a slight error. As a reason for that, SearchYJ pick up the records which has excepted the advertisements in the search result. The exception feature is rough machining yet.


### list

Print the search results that has collected the ordered number.

    $ searchyj list [options] <SearchTerm>

If the search result was nothing, print a string of an empty Array.

#### --size, -s

The size of the result records.

If a number of the search result is less than this option's value, search for next page until the sum of the results reach to option's value.

If reach the end of searching before reach to option's value, print the collected records at that time.

The default value is 10.


#### --from, -f

Start to search from this number of the search ranking.


### detect

Print a record of the search result that has matched own arguments.

    $ searchyj detect [options] <SearchTerm>

If the search result was nothing or did not find, print a string of null.

#### --regexp, -r

A string as a regular expression that want to match with value of a record[key].

The option is required.

#### --key, -k

The key name for comparing values. You can pass any of 'title' or 'uri'. 

The default value is 'title'.

#### --from, -f

Start to search from this number of the search ranking.


### rank

Print a record of the search result at a particular rank order in the search ranking.

    $ searchyj rank [options] <SearchTerm>

If the search result was nothing or did not find, print a string of null.

#### --rank, -r

The rank order in the search ranking.

The option is required.

## Usage (Programming)

Please read 'lib/searchyj.rb' and others.

## Author

[indeep-xyz](http://blog.indeep.xyz/)
