# SearchYJ

Search on Yahoo Japan.

## Installation

Gemfile に次の一行を書き加えてください。

~~~ruby
gem 'searchyj'
~~~

そして以下を実行。

    $ bundle

もしくは、以下のようにしてインストール。

    $ gem install searchyj

## Usage (CLI)

出力結果は基本的に JSON 形式で、以下のパラメータを持ちます。

- uri
- title
  - 検索結果のタイトルをそのまま収集するため、省略されている場合があります。
- rank
  - 検索順位。
  - SearchYJ では検索に混じる広告を排除しながらレコードを拾っています。この機能が貧弱なため、多少値がずれることがあります。

### list

検索結果を指定の個数揃えて出力します。

    $ searchyj list [options] <SearchTerm>

検索にひとつも引っかからない場合は空の配列を表す文字列が出力されます。

#### --size, -s

結果結果のサイズです。

一度の検索でこの値に満たなかった場合、この値に届くまで検索を繰り返します。値に到達するより先に検索が最後まで到達した場合には、それまでに集めた検索結果を返します。

未設定時は 10 です。

#### --from, -f

指定の順位から検索を開始します。

### detect

条件に合う検索結果を探し、最初に合った結果を出力します。

    $ searchyj detect [options] <SearchTerm>

検索にひとつも引っかからない場合は文字列 _null_ が出力されます。

#### --regexp, -r

マッチさせたい正規表現用の文字列です。マッチさせるパラメータの種類は _--key_ オプションに依存しています。

必須です。

#### --key, -k

比較対象のキー名です。 _title_ か _uri_ を渡すことができます。

未設定時は _title_ となります。

#### --from, -f

指定の順位から検索を開始します。

### rank

指定順位の検索結果を出力します。

    $ searchyj rank [options] <SearchTerm>

検索にひとつも引っかからない場合は文字列 _null_ が出力されます。

#### --rank, -r

出力したいレコードの順位です。

必須です。

## Usage (Programming)

_lib/searchyj.rb_ やその他を読んでください。

## Author

[indeep-xyz](http://blog.indeep.xyz/)
