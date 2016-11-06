# Fresh Fridge
## 製品概要
### Food Tech
### 背景（製品開発のきっかけ、課題等）
課題：日本の一般家庭から廃棄される（本来なら食べられるはずの）食品は年間200〜400万t。（出展：[食品ロス削減に向けて](http://www.maff.go.jp/j/shokusan/recycle/syoku_loss/pdf/0902shokurosu.pdf)）
今回のFreshFridgeでは、こういった家庭から出る食品の廃棄を減らすため、iPhoneアプリケーションとAndroidタブレットを組み合わせ、冷蔵庫と消費者のスマートフォンと連動させたアプリケーションを作成し、ユーザーが食品を無駄にすることなく使ってもらうことを目指している。また、ただモバイルアプリケーションで食品を管理するだけで開く、レシピの提案やハード、実店舗との連携により、より包括的なアプローチを試みた。
### 製品説明（具体的な製品の説明）
### 特長
####1. 買い物のレシートをカメラで作成し、画像解析をし食品の情報を自動で取得。StillTastyという賞味期限情報を検索できるサイトの情報から独自に作成した、賞味期限データベースを元に賞味期限を算出する。これらのデータはサーバー内に保存し、携帯端末や冷蔵庫に貼り付ける端末が取得する形で情報を同期して表示する。
####2. 賞味期限が近い食品の通知をLINEを介してユーザーに行う。また冷蔵庫側に設置されたディスプレイで冷蔵庫の開閉を感知し、冷蔵庫を開けた際には賞味期限間近の食品があることを通知する。
####3. 冷蔵庫に残った食品をユーザーが効率的に消化できるよう、おすすめレシピをより賞味期限の迫った食品を使ったレシピを中心に紹介する。レシピの紹介についてはアプリ内で独自に楽天レシピ内のそれらの条件に合致するレシピを検索するクエリを生成し、それに基づいて結果を表示する。
####4. LINEビーコンを使用し、提携店にユーザーが近づくと賞味期限間近の食品を通知し、ユーザーが何が賞味期限か伝える。

### 解決出来ること
* 賞味期限を超えたことによる廃棄
* 家に十分な食材があるのに新しく買ってしまう
* 家にある食材を効率よく使う。

### 今後の展望
* 今回はタッチディスプレイの実現と人感センサの両立のためにAndroidタブレットとRaspberry Piの二つを連携させた。これを一つの機器で実現させる。
* 読み取ったレシートを活用した家計簿機能
*  (特にAndroidスマートフォン向けに) NFCタグを実装し、NFCの読み取りだけでアプリの起動、データの連携を行う。
* 値段について、より損失額をユーザーが意識するために通知機能、ユーザーデファルとでの管理、ライングループへの投稿など徹底したい。

### 注力したこと（こだわり等）
* 複数デバイス、店舗との連携をLineサービスの活用、QRコードの活用などにより簡単にした。
* 賞味期限情報だけでなく、値段情報を合わせて保存することで、より「損失額」を表し、よりユーザに食べ残しを無くさせる。
* 多様な入力に対応する高精度な解析、データベース。レシートに「きゅうり」「きゆうり」「ｷｭｳﾘ」と書かれていても、すべてキュウリとして扱われるようにした。
* ユーザーにとってストレスのないユーザーインターフェース。多様な入力方法など。
* サーバーに賞味期限のデータが存在しなかったり、ユーザーがおつとめ品を購入した時用に、ユーザーが賞味期限を入力・調整できるように

## 開発技術

### 活用した外部技術
* Rakuten MA(形態素解析)<https://github.com/rakuten-nlp/rakutenma/blob/master/README-ja.md>
* Google Could Vision API(画像解析)<https://cloud.google.com/vision/>

#### API・データ
* Google Could Vision API
* StillTasty

#### フレームワーク・ライブラリ・モジュール
##### API側
c[Slim Framework](http://www.slimframework.com/)
* [Monolog](https://github.com/Seldaek/monolog)
* [PHP implementation of JSON schema](https://github.com/justinrainbow/json-schema)
* [Propel](http://propelorm.org/)
* [pecl Redis](https://pecl.php.net/package/redis)
* [pecl YAML](https://pecl.php.net/package/yaml)
* 初期のテンプレートにslim/slim-skeletonを使用

##### iOS側
* [RealmSwift](https://realm.io/jp/docs/swift/latest/)
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [FlatUIKit](https://github.com/Grouper/FlatUIKit)
* [SCLAlertView](https://github.com/vikmeup/SCLAlertView-Swift)
* [BRYXBanner](https://github.com/bryx-inc/BRYXBanner)

#### デバイス
* iPhone
* Androidタブレット
* RasberryPi
* 人感センサー、モーションセンサー


### 独自技術
#### 期間中に開発した独自機能・技術
* Raspberry Piを介したAndroidタブレットと人感センサの連携
* 独自で開発したものの内容をこちらに記載してください
* 特に力を入れた部分をファイルリンク、またはcommit_idを記載してください（任意）

#### 研究内容（任意）
* もし、製品に研究内容を用いた場合は、研究内容の詳細及び具体的な活用法について、こちらに記載をしてください。
* 
