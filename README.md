# 翻訳アプリ

![gif](https://user-images.githubusercontent.com/82624334/205308674-7927682a-332a-4a1e-8312-3eb484debe8d.gif)

## 主な機能
 - 翻訳（日<->英）
 - 音声読み上げ
 - テキストをクリップボードにコピー
 
## 開発メンバー
1人

## 使用したフレームワーク
* Flutter

## 使用した主なpackage（ライブラリ）
* translator
  * https://pub.dev/packages/translator
  * 翻訳を行う
* fluttertoast
  * https://pub.dev/packages/fluttertoast
  * トーストを表示
* flutter_tts
  * https://pub.dev/packages/flutter_tts
  * テキスト読み上げ
* flutter_launcher_icons
  * https://pub.dev/packages/flutter_launcher_icons
  * アプリアイコン変更

## テックブログ
今回の開発についてテックブログを執筆しました。
「Flutter 翻訳」と検索したら上から2番目に表示されます。
https://blog.shinonome.io/flutter-translate/

## 大変だったこと
2つのテキストボックス（テキストフィールド）に対して状態管理を行うのが大変でした。
なぜなら、片方のテキストボックスに日本語が入力されると、もう片方のテキストボックスに英語が出力されるという仕様だったからです。
extentionと列挙型を組み合わせてコードを上手くまとめることで、状態管理を行いやすくしました。
