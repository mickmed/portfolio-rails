class Project < ApplicationRecord
    has_and_belongs_to_many :technologies
end
