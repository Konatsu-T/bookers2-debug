class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false
  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }

  # フォロー取得
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロワー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローしている人(:through 中間テーブルを経由し関連先のモデルを取得。has_manyと合わせて使用)
  has_many :following_user, through: :follower, source: :followed
  # 自分をフォローしている人(:soure :throughで示された経路の先で、どの関連を使用するかを示す)
  has_many :follower_user, through: :followed, source: :follower

  # ユーザーをフォローする
  def create(user_id)
    follower.create(followed_id: user_id)
  end
  # ユーザーのフォローを外す
  def destroy(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  # フォローしていればtrueを返す
  # include：複数テーブルからデータ取得する際のアクセス回数を減らせる
  def following?(user)
    following_user.include?(user)
  end
end
