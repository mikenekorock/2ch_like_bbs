class Sub < ActiveRecord::Base
  belongs_to :main
  validates :text, presence: true
  #gsub (/>>(\d{1,2})/, "<a href=#></a>"):text
end
