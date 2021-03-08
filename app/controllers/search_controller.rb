class SearchController < ApplicationController
 before_action :authenticate_user!
 #  検索用に新規追加

  def search
    @model = params["search"]["model"]
    # 選択したmodelを@mdelに代入
    @content = params["search"]["content"]
    # 検索にかけた文字列contentを＠contentに代入
    @method = params["search"]["method"]
    # 選択した検索方法methodを＠methodに代入
    @records = search_for(@model, @content, @method)
    # @recordsに最終的な検索結果が入る
  end

  private
  def search_for(model, content, method)
    #searchアクションで定義した情報が引数に入っている
    if model == 'user'
      #modelがuserの場合の処理
      if method == 'perfect'
        User.where(name: content)
          #whereでcontentと完全一致するnameを探します
      elsif method == 'forward'
        User.where('name LIKE ?', content+'%')
        # 前方一致
        # モデル名.where("カラム名 LIKE ?", "値%")
      elsif method == 'backward'
        User.where('name LIKE ?', '%'+content)
        # 後方一致
        # モデル名.where("カラム名 LIKE ?", "%値")
      else
        User.where('name LIKE ?', '%'+content+'%')
        # 部分一致
        # モデル名.where("カラム名 LIKE ?", "%値%")
      end

    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'forward'
        Book.where('title LIKE ?', content+'%')
      elsif method == 'backward'
        Book.where('title LIKE ?', '%'+content)
      else
        Book.where('title LIKE ?', '%'+content+'%')
      end
    end
  end
end

