require 'dm-core'

module DataMapper
    module Historylog

        def self.included(base)
            base.class_eval do
                after    :create,    :history_create
                after    :save,      :history_save_after                
                #before   :save,      :history_save_before
                before   :update,    :history_update
                before   :destroy,   :history_destroy
                
                def history_create
                    Historial.do Historial::CREATED, self
                end

                def history_save_before
                    #self.history_update unless self.new?
                end

                def history_save_after
                    # Fewer queries... [avillagran]
                    self.history_create if self.new?
                    #self.historylog.empty? ? self.history_create : self.history_update
                end


                def history_update
                    # Fewer queries... [avillagran]
                    #if self.deleted_at.nil? && self.historylog.last.current_state != self.attributes.to_json
                    
                    Historial.do Historial::UPDATED, self if (self.attributes.include?(:deleted_at) ? self.deleted_at.blank? : true)
                    #end
                end

                def history_destroy
                    Historial.do Historial::DELETED, self
                end

                def historylog
                    Historial.all historiable_type: self.class.to_s, historiable_id: self.id
                end

                def v property, default = '', default2 = ''
                    
                    val = self.nil? ? (default.class != String ? default2 : default) : self.send(property)
                    if !self.nil? && default.class != String 
                      val = self.send(property).nil? ? default2 : self.send(property).send(default)
                    end

                    return val
                end
            end
        end

    end

end