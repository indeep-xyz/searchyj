# SearchYJ

Search on Yahoo Japan.

Installation
----

Add this line to your application's Gemfile:

~~~ruby
gem 'searchyj'
~~~

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install searchyj

## Usage (CLI)

The format of the search result is JSON which includes parameters the followings.

- uri
- title
  - The title might be abbreviated because its source string is from the list of the search result.
- rank
  - The number of the rank order in the search result.
  - This number might have a slight error. The records collected by SearchYJ is excepted some advertisements from the search result. The feature of exception is rough yet.

### list

Print the search result.

    $ searchyj list [options] <SearchTerm>

If the number of the result is none, SearchYJ print an empty array in the form of string.

#### --size, -s

This number is the size of the result records.

SearchYJ continues searching and to collecting records until the sum of the records reach the size value.

If searching is over or become unable to get new records, before reach the size value, SearchYJ print the collected records at that time.

The default value is 10.

#### --from, -f

The searching process starts from this number of the search ranking.

### detect

Print the record matched first with the search term.

    $ searchyj detect [options] <SearchTerm>

If the matching record is none, SearchYJ print a _null_ in the form of string.

#### --regexp, -r

This value is a regular expression used to extract from the search result. The matching target in the parameters is depended on the value of _--key_ option.

This option is required.

#### --key, -k

This value is the name of the matching target which a key name of parameters in records. This option receives any of _title_ or _uri_.

The default value is _title_.

#### --from, -f

The searching process starts from this number of the search ranking.

### rank

Print a particular record extracted from the search result by the number of rank order.

    $ searchyj rank [options] <SearchTerm>

If the matching record is none, SearchYJ print a _null_ in the form of string.

#### --rank, -r

This value is the number of rank order in the search result.

This option is required.

## Usage (Programming)

Please read _lib/searchyj.rb_ and others.

## Author

[indeep-xyz](http://blog.indeep.xyz/)
