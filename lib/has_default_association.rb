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
    def has_default_association *names, &default_proc
      names.each do |name|
        create_default_association(name, default_proc)
      end
    end
    
    private
    
    def create_default_association name, default_proc
      setter = :"#{name}="
      
      default_proc ||= proc do |model| 
        model.association(name).build
      end
      
      define_method(name) do
        target = association(name).load_target
        return target unless target.blank?
        
        self.send setter, default_proc.call(self)
      end
    end
    
  end
  
end