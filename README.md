Google Analytics Chart
======================
Google Analytics APIからデータを取得し、グラフを作ります。ただそれだけです。  

下記のGemを利用します。

* [garb (A Ruby wrapper for the Google Analytics API)](https://github.com/vigetlabs/garb)
* [gruff (Gruff graphing library for Ruby)](https://github.com/topfunky/gruff)

使い方
------
1.config.yamlを作成する  

    user:
        name:     (Google Analyticsのユーザー名)
        password: (Google Analyticsのパスワード)
    
    profile:
        id:    (Google AnalyticsのアカウントID)
        title: (プロファイルのタイトル)

2.実行する
`make_chart.rb yyyy-mm`

ライセンス
----------
Copyright &copy; 2011 nobuyuki.matsui@gmail.com
Licensed under the [GPL license Version 2.0][GPL]

[GPL]: http://www.gnu.org/licenses/gpl.html
