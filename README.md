# Fresh Fridge
## 製品概要
### Food Tech
### 背景（製品開発のきっかけ、課題等）
課題：日本の一般家庭から廃棄される（本来なら食べられるはずの）食品は年間200〜400万t。（出展：[食品ロス削減に向けて](http://www.maff.go.jp/j/shokusan/recycle/syoku_loss/pdf/0902shokurosu.pdf)）
今回のFreshFridgeでは、こう言った家庭から出る食品の廃棄を減らすため、iPhoneアプリケーションとRaspberryPiを組み合わせ、冷蔵庫と消費者のスマートフォンと連動させたアプリケーションを作成し、ユーザーが食品を無駄にすることなく使ってもらうことを目指している。
### 製品説明（具体的な製品の説明）
### 特長
####1. 買い物のレシートをカメラで作成し、画像解析をし食品の情報を自動で取得。StillTastyという賞味期限情報を検索できるサイトの情報から独自に作成した賞味期限データベースを元に賞味期限を算出する。これらのデータはiOSアプリケーションとAndoroidアプリケーションとRasberryPiと連携したディスプレイ内に情報を保存する。
####2. 賞味期限が近づいた食品に対してユーザーに通知を行う。また冷蔵庫側に設置されたディスプレイで冷蔵庫の開閉を感知し、冷蔵庫を開けた際には賞味期限間近の食品があることを通知する。またLINEビーコンを使用し、提携店にユーザーが近づくと賞味期限間近の食品を通知し、ユーザーが何が賞味期限か伝える。
####3. 冷蔵庫に残った食品をユーザーが効率的に消化できるよう、おすすめレシピをより賞味期限の迫った食品を使ったレシピを中心に紹介する。レシピの紹介についてはアプリ内で独自に楽天レシピ内でそれらの条件に合致するレシピを検索できるようクエリを生成し、それに基づいて結果を表示する。


### 解決出来ること

### 今後の展望

### 注力したこと（こだわり等）
* 
* 

## 開発技術


### 活用した外部技術

* Rakuten MA(形態素解析)<https://github.com/rakuten-nlp/rakutenma/blob/master/README-ja.md>
* Google Could Vision API(画像解析)<https://cloud.google.com/vision/>

#### API・データ
* Google Could Vision API  
* StillTasty  

#### フレームワーク・ライブラリ・モジュール
##### API側
* [Slim Framework](http://www.slimframework.com/)
* [Monolog](https://github.com/Seldaek/monolog)
* [PHP implementation of JSON schema](https://github.com/justinrainbow/json-schema)
* [Propel](http://propelorm.org/)

#### デバイス
* iPhone
* Androidタブレット
* RasberryPi
* 人感センサー、モーションセンサー


### 独自技術
#### 期間中に開発した独自機能・技術
* 独自で開発したものの内容をこちらに記載してください
* 特に力を入れた部分をファイルリンク、またはcommit_idを記載してください（任意）

#### 研究内容（任意）
* もし、製品に研究内容を用いた場合は、研究内容の詳細及び具体的な活用法について、こちらに記載をしてください。
* 
