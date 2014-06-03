class Sub < ActiveRecord::Base
  belongs_to :main
  validates :text, presence: true
  #params[:text].gsub(/>>(\d{1,3})/, "<a href=#>ohoo</a>")
end
