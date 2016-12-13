# 第8回 (11/30)レポート(team-amn:東野研)
### メンバー
* 今井 友揮
* 成元 椋祐
* 西村 友佑
* 原 佑輔
* 三浦 太樹

## 1. スライスの分割・結合
### 1.1 コマンドの仕様
　スライスの分割ではサブコマンド`split`を定義した．
[講義資料](http://handai-trema.github.io/deck/week8/sliceable_switch.pdf)を参考に、スライスに属する各ホストの指定にはMACアドレスを用いるものとして
、サブコマンドの仕様を定義した．
host1(MACアドレス: 11:11:11:11:11:11)・host2(22:22:22:22:22)・host3(33:33:33:33:33:33)・host4(44:44:44:44:44:44)が属するslice_aを、host1・host2が属するslice_bと、host3・host4が属するslice_cに分割する際は以下のようにコマンドを実行する．
```
./bin/slice split slice_a --into slice_b:11:11:11:11:11:11, 22:22:22:22:22:22 slice_c:33:33:33:33:33:33, 44:44:44:44:44:44
```   
　スライスを分割する際に、分割元のスライスに属する全てのホストを分割先のスライスに割り当てなかった場合、分割元のスライスは残す仕様とした．

　スライスの結合ではサブコマンド`join`を定義した．
コマンドの仕様は、引数として結合元のスライスをスペースで区切って指定し、結合後の新たなスライス名を`--into`オプションで指定するものとした．
２つのスライスslice_aとslice_bを結合し、新たにslice_cを作成する際のコマンド例は以下となる．
```
./bin/slice join slice_a slice_b --into slice_c
```
### 1.2 実装内容
 　スライスの分割・結合を実装するにあたって修正、作成した主なファイルについて説明する．
* /bin/slice
 * スライスの分割・結合を実行する際のコマンドを定義
* /lib/slice.rb
 * スライスの分割・結合を行うメソッドとしてsplitとjoinを追加


## 2. スライスの可視化
### 2.1 使用方法
　/output/index.htmlによって表示されるトポロジ図において、ホストの属するスライスの情報を重ねて表示する．index.htmlでは、トポロジ図におけるホストのラベルとして出力されるMACアドレスの文字の色をスライスごとに異なる色で表示される．  
　index.htmlは1秒間隔で更新されるが、表示間隔の更新にはタイムスタンプの取得が必要である．事前準備として/output/server.shを起動する必要がある．

### 2.2 ファイルの呼び出し関係図
　以下にファイルを介して行っているコントローラプロセス~ブラウザ間のトポロジ情報，スライス情報のやり取りの関係を図で示す．

![関係図](./fileflow.png)


### 2.3 実装内容
* /lib/slice.rb
 * スライスの出力ファイルslice.jsを出力するメソッドwrite_slice_infoを追加．このメソッドでは、Sliceクラスのクラス変数allを参照し、スライスごとに生成されるSliceクラスのインスタンスから、そのスライスに属するホストのmacアドレスを取得し、スライスの情報をノードのラベルの色情報として付加してslice.jsに出力している．





## 3. REST APIの追加
### 3.1 実装内容
　スライスの分割・統合を行うREST APIを追加するために，以下の通り `lib/rest_api.rb`に分割を行う`Split a slice.`，統合を行う`Join a slice.`から始まるブロックをそれぞれ追加した．

 ```
   desc 'Split a slice.'
   params do
     requires :base_slice_id, type: String, desc: 'Base slice.'
     requires :into_slices_id, type: String, desc: 'Into slices(multiple).'
   end
   intoAry = params[:into].split(",")
   get 'base_slice_id/:base_slice_id/into_slices_id/:into_slices_id' do
     rest_api do
       Slice.find_by!(name: params[:slice_id]).
         split(params[:base_slice_id], intoAry)
     end
   end
 ```
 ```
   desc 'Join a slice.'
   params do
     requires :base_slices_id, type: String, desc: 'Base slices(multiple).'
     requires :into_slice_id, type: String, desc: 'Into slice.'
   end
   baseAry = params[:base].split(",")
   get 'base_slices_id/:base_slices_id/into_slice_id/:into_slice_id' do
     rest_api do
       Slice.find_by!(name: params[:slice_id]).
         join(baseAry, params[:into_slice_id])
     end
   end
 ```

　既に実装されていたものを参考にしてこれらを実装した．`Slice`クラスにおいて定義した，スライスの分割を行うための`split`メソッド，スライスの統合を行うための`join`メソッドをそれぞれ呼び出す処理を行う．  
　以下にスライスの分割，統合それぞれのコマンドについての簡素な説明を示す．

### ①分割
　第１入力引数に分割されるスライスIDである`base_slice_id`，第２入力引数に分割後のそれぞれのスライスIDである`into_slices_id`を入力することで，REST APIによるスライスの分割機能を実現する．このとき，第２引数には`,`区切りで分割先のスライスIDを入力する必要がある．  
　以下に分割機能のコマンドの使い方の例を示す．  
```
curl -sS -X GET 'http://localhost:9292/base_slice_id/slice_a/into_slices_id/slice_b,slice_c'
```

### ②統合
　第１入力引数に統合したいスライス（複数）を`,`で区切ったID，第２入力引数に統合後に新たに生成されるスライスIDを入力することで，REST APIによるスライスの統合機能を実現する．  
　以下に統合機能のコマンドの使い方の例を示す．  
```
curl -sS -X GET 'http://localhost:9292/base_slices_id/slice_a,slice_b/into_slice_id/slice_c'
```


## 4. 仮想ネットワークでの動作検証
　./trema.confでのネットワークトポロージを使用し、仮想ネットワークにおいて動作を検証した．コントローラを起動後、コマンドライン上でスライスを定義した上で、スライスの分割・結合を行い、ブラウザ上で表示されるトポロジ図を確認した．
### STEP.1 スライスの作成
### STEP.2 スライスの分割
### STEP.3 パケットの送信
### STEP.4 スライスの結合
### STEP.5 パケットの送信

## 5. 実機での動作検証
### 5.1 実機で検証する際の修正点
実機でsliceable-switchを動作させる上で、発見した課題とその解決策を述べる．
#### フローエントリの重複
　実機を用いた動作検証において、ping等で発信元と送信先の同じパケットを複数回送信すると、発信元と送信先の同じのフローエントリが複数生成される事を確認した．  
　この現象は/lib/path.rbがpacket_inを処理する際に、フローエントリへ書き加える処理のマッチングルールをpacket_inの発生したパケットと"全く同じパケットであった場合"としたためと考えられる．pingのように同じパスを経由するパケットであっても、各パケットはICMPが異なるので、初めに到着したパケットによって追加されたフローエントリは次のパケットにマッチしないとハードウェアが判断し、再びpacket_inが発生した結果と考えられる．そこで、新しく追加するフローエントリのマッチフィールドをpacket_inの発生するパケットと全く同じパケットではなく、宛先ipアドレスが同じであることを条件とした．  
　この際、OpenFlowの仕様として宛先IPのみをマッチングルールにできないので、IPv4パケットとARPパケットのイーサタイプを同時にマッチングルールの条件として指定した．
