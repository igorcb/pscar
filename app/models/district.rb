class District < ActiveRecord::Base
	#has_many :origins, class_name: 'Rate', foreign_key: 'district_origin_id'
	has_many :targets, class_name: 'Rate', foreign_key: 'district_target_id'

	validates :name, presence: true, uniqueness: true, length: { maximum: 250 }
  
  before_save { |district| district.name = name.upcase } 

  before_destroy :can_destroy?

  def target_order
  	Rate.includes(:target).where(district_origin_id: self.id).order('districts.name asc')
  end

  def rates
    Rate.where(district_origin_id: self.id)
  end

  private 
    def can_destroy?
      # if self.origin.present? || 
      #    self.targets.present?
       if self.targets.present?

        puts ">>>>>>>>>>>>>>>>>>>>>>>>>. não pode apagar"
        #errors.add(:base, "You can not delete record with relationship") 
        #self.errors.add(:name, "You can not delete record with relationship") 
        errors.add("District", " You can not delete record with relationship.")
        return false
      end
    end

end
