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
    requires :base, type: String, desc: 'Base slice.'
    requires :into1, type: String, desc: 'Into slice1.'
    requires :into2, type: String, desc: 'Into slice2.'
  end
  get 'base_slice_id/:base/into_slices1_id/:into1/into_slices2_id/:into2' do
    rest_api do
      *into = into1, into2
      Slice.find_by!(name: params[:slice_id]).
        split(params[:base], *into)
    end
  end

  desc 'Join a slice.'
  params do
    requires :base1, type: String, desc: 'Base slice1.'
    requires :base2, type: String, desc: 'Base slice2.'
    requires :into, type: String, desc: 'Into slice.'
  end
  get 'base_slice1_id/:base1/base_slice2_id/:base2/into_slice_id/:into' do
    rest_api do
      *base = base1, base2
      Slice.find_by!(name: params[:slice_id]).
        join(*base, params[:into])
    end
  end
```

既に実装されていたものを参考に

###①分割



## 実機での検証
