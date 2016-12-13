# 第8回 (11/30)レポート1(team-amn:東野研)
### メンバー
* 今井 友揮
* 成元 椋祐
* 西村 友佑
* 原 佑輔
* 三浦 太樹

## 課題1 スライスの分割、結合
### コマンドの仕様
スライスの分割ではサブコマンド`split`を定義した．
[講義資料](http://handai-trema.github.io/deck/week8/sliceable_switch.pdf)のコマンド例と同様に、host1・host2・host3・host4が属するslice_aを、host1・host2が属するslice_bとhost3・host4が属するslice_cに分割する際は以下のように実行する．この時、各ホストはMACアドレスによって指定する．
```
./bin/slice split  
```
スライスの結合ではサブコマンド`join`を定義した．
### 実装内容

## 課題2 スライスの可視化
### 実装内容

## 課題3 REST APIの追加
### 実装内容

## 仮想ネットワークでの動作検証


## 実機での動作検証
### 実機で検証する際の修正点
実機でsliceable-switchを動作させる上で、発見した課題とその解決策を述べる．
#### icmpの変更
#### dropbox等、関係ないパケット
#### ARPとIPv4Packetの呼び出しの違い
