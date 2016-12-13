# 第8回 (11/30)レポート1(team-amn:東野研)
### メンバー
* 今井 友揮
* 成元 椋祐
* 西村 友佑
* 原 佑輔
* 三浦 太樹

## 課題1 スライスの分割、結合
### コマンドの仕様
### 実装内容

## 課題2 スライスの可視化
### 実装内容

## 課題3 REST APIの追加
### 実装内容
スライスの分割・統合を行うREST APIを追加するために，以下の通り ```lib/rest_api.rb```に分割を行う```Split a slice.```，統合を行う```Join a slice.``` から始まるブロックをそれぞれ追加した．

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

既に実装されていたものを参考にしてこれらを実装した．```Slice```クラスにおいて定義した，スライスの分割を行うための```split```メソッド，スライスの統合を行うための```join```メソッドをそれぞれ呼び出す処理を行う．  
以下にスライスの分割，統合それぞれのコマンドについての簡素な説明を示す．

###①分割
第１入力引数に分割されるスライスIDである```base_slice_id```，第２入力引数に分割後のそれぞれのスライスIDである```into_slices_id```を入力することで，REST APIによるスライスの分割機能を実現する．このとき，第２引数には```,```区切りで分割先のスライスIDを入力する必要がある．  
以下に分割機能のコマンドの使い方の例を示す．
```curl -sS -X GET 'http://localhost:9292/base_slice_id/slice_a/into_slices_id/slice_b,slice_c'```

###②統合
第１入力引数に統合したいスライス（複数）を```,```で区切ったID，第２入力引数に統合後に新たに生成されるスライスIDを入力することで，REST APIによるスライスの統合機能を実現する．  
以下に統合機能のコマンドの使い方の例を示す．
```curl -sS -X GET 'http://localhost:9292/base_slices_id/slice_a,slice_b/into_slice_id/slice_c'```


## 実機での検証
