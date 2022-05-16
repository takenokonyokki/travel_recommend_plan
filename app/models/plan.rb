class Plan < ApplicationRecord

  has_many :contents, dependent: :destroy
  belongs_to :user
  belongs_to :comment, optional:true
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :travel, presence: true

  has_one_attached :image

  enum travel: {
    hokkaido: 0, aomori: 1, iwate: 2, miyagi: 3, akita: 4, yamagata: 5, fukushima: 6, ibaraki: 7, tochigi: 8, gunma: 9, saitama: 10, chiba: 11, tokyo: 12, kanagawa: 13,
    niigata: 14, toyama: 15, ishikawa: 16, fukui: 17, yamanashi: 18, nagano: 19, gifu: 20, shizuoka: 21, aichi: 22, mie: 23, shiga: 24, kyoto: 25, osaka: 26, hyogo: 27,
    nara: 28, wakayama: 29, tottori: 30, shimane: 31, okayama: 32, hiroshima: 33, yamaguchi: 34, tokushima: 35, kagawa: 36, ehime: 37, kochi: 38, fukuoka: 39, saga: 40,
    nagasaki: 41, kumamoto: 42, oita: 43, miyazaki: 44, kagoshima: 45, okinawa: 46
  }

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io:File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search)
    if search != ""
      search = search.delete("都")
      search = search.delete("県")
      search = search.delete("府")
      Plan.where(['title LIKE(?) OR travel LIKE(?)', "%#{search}%", self.prefecture_num(search) ])
    else
      Plan.includes(:user).order('created_at DESC')
    end
  end

  def self.prefecture_num(prefecture_kanji)
    self.kanji_prefecture_hash[prefecture_kanji]
  end

  def self.kanji_prefecture_hash
    {"北海道"=> 0, "青森"=> 1, "岩手"=> 2, "宮城"=> 3, "秋田"=> 4, "山形"=> 5, "福島"=> 6, "茨城"=> 7, "栃木"=> 8, "群馬"=> 9, "埼玉"=> 10, "千葉"=> 11, "東京"=> 12,
     "神奈川"=> 13, "新潟"=> 14, "富山"=> 15, "石川"=> 16, "福井"=> 17, "山梨"=> 18, "長野"=> 19, "岐阜"=> 20, "静岡"=> 21, "愛知"=> 22, "三重"=> 23, "滋賀"=> 24,
     "京都"=> 25, "大阪"=> 26, "兵庫"=> 27, "奈良"=> 28, "和歌山"=> 29, "鳥取"=> 30, "島根"=> 31, "岡山"=> 32, "広島"=> 33, "山口"=> 34, "徳島"=> 35, "香川"=> 36,
     "愛媛"=> 37, "高知"=> 38, "福岡"=> 39, "佐賀"=> 40, "長崎"=> 41, "熊本"=> 42, "大分"=> 43, "宮崎"=> 44, "鹿児島"=> 45, "沖縄"=>46}
  end

end
