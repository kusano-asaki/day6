# pgライブラリを使用する
require 'pg'
# PG::connect(dbname: "goya")により、rubyからgoyaDBに接続し
# 接続したという情報をconnectionという名前の変数に格納する
connection = PG::connect(dbname: "goya")
connection.internal_encoding = "UTF-8"
begin
  # connection変数を使いPostgreSQLを操作する
  # .execで、goyaDBに"select weight, give_for from crops;"
  # のSQLの命令文を直接実行し、その結果をresult変数に格納する
  result = connection.exec("SELECT * FROM crops WHERE give_for != '自家消費';")
  # 取り出した各行を処理する
  result.each do |record|
      # 各行を取り出し、putsでターミナル上に出力する
      puts "ゴーヤの大きさ：#{record["weight"]}　ゴーヤの長さ：#{record["length"]}　品質：#{record["quality"]} 収穫日：#{record["date"]} 売った相手：#{record["give_for"]}"
  end
  result2 = connection.exec("SELECT * FROM crops WHERE quality = false;")
  result2.each do |record|
    puts "ゴーヤの大きさ：#{record["weight"]}　ゴーヤの長さ：#{record["length"]} 品質：#{record["quality"]} 収穫日：#{record["date"]} 売った相手：#{record["give_for"]}"
  end
ensure
  # 何かしらのエラーが発生した場合、
  # .finishでデータベースへのコネクションを切断する
  connection.finish
end
