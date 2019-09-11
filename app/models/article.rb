class Article < ApplicationRecord
  has_one_attached :file, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 3}

  def self.to_csv
    #attributes = %w{title text comments}
    CSV.generate(headers: true) do |csv|
      #csv << attributes
      csv << ["Title", "Text", "Comments"]

      all.each do |article|
        #csv << attributes.map{ |attr| article.send(attr)}
        #csv << article.attributes.values_at(*attributes)

        if article.comments.any?
          row = [article.title, article.text]
          comments = ""
          article.comments.each do |comment|
            comments += comment.body + ";"
          end
          row << comments
          csv << row
        else
          csv << [article.title, article.text]
        end
      end
    end
  end
=begin
  def comments
    comments.each do |comment|
      "#{comment.body}"
    end  
  end
=end 
end
