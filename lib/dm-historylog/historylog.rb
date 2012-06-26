require 'dm-core'

module DataMapper
    module Historylog

        def self.included(base)
            base.class_eval do
                after   :create,    :history_create
                after   :save,      :history_save
                after   :update,    :history_update
                after   :destroy,   :history_destroy
                
                def history_create
                    Historial.do Historial::CREACION, self
                end

                def history_save
                    self.historylog.empty? ? self.history_create : self.history_update
                end

                def history_update
                    if self.deleted_at.nil? && self.historylog.last.estado_actual != self.attributes.to_json
                        Historial.do Historial::ACTUALIZACION, self
                    end
                end

                def history_destroy
                    Historial.do Historial::ELIMINACION, self
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