class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

  def Book.search(search, user_or_post, how_search)
    if user_or_post == "2"
      # 部分一致
      if how_search == "1"
         Book.where(['title LIKE ?', "%#{search}%"])
      # 後方一致
      elsif how_search == "2"
        Book.where(['title LIKE ?', "%#{search}"])
      # 前方一致
      elsif how_search == "3"
        Book.where(['title LIKE ?', "#{search}%"])
      # 完全一致
      elsif how_search == "4"
        Book.where(['title LIKE ?', "#{search}"])
      else
        Book.all
      end
    end
  end

end
