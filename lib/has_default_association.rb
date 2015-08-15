module HasDefaultAssociation
  extend ActiveSupport::Concern
  
  included do
    # no-op 
  end

  module ClassMethods
    # Declare default associations for ActiveRecord models.
    # 
    #   # Build a new association on demand
    #   belongs_to :address
    #   has_default_association :address 
    #
    #   # Build a custom assocation on demand
    #   belongs_to :address
    #   has_default_association :address do |model|
    #     Address.new(:name => model.full_name)
    #   end
    # 
    def has_default_association name, &default_proc
      setter = :"#{name}="
      
      default_proc ||= proc{|model| model.association(name).build }

      define_method(name) do
        association(name).load_target || begin
          self.send setter, default_proc.call(self)
        end
      end
    end
    
  end
  
end