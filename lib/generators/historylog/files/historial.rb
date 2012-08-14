# encoding: utf-8
class Historial
    include DataMapper::Resource
    include DataMapper::Timestamps

    storage_names[:default] = 'historylogs'

    CREATED   = 'Created'
    UPDATED   = 'Updated'
    DELETED   = 'Deleted'

    property :id,               Serial
    property :original_state,   Text
    #property :current_state,    Text #
    property :original_date,    DateTime
    #property :current_date,     DateTime #
    property :comment,          Text    

    property :historiable_type, String
    property :historiable_id,   Integer

    timestamps :at

    #belongs_to :user, :required => false

    def self.do comment, item, params = {auto: true}
        h = Historial.new :historiable => item, :comment => comment

        # Fewer queries [avillagran]
        # if params[:auto] == true
        #             
        #             # old = Historial.last :historiable_id => item.id, :historiable_type => item.class.to_s
        #             #             if old
        #             #                 h.original_date     = old.current_date
        #             #                 h.original_state    = old.current_state
        #             #             end
        #             
        #             h.current_date      = item.updated_at           if item.attributes.has_key?(:updated_at)
        #         else
        #             h.original_date     = params[:original_date]    if params.has_key? :original_date
        #             h.original_state    = params[:original_state]   if params.has_key? :original_state
        #         end
        #h.current_state = params[:current_state]    if params.has_key? :current_state
        h.original_date = DateTime.now if h.original_date.nil?
        
        if comment == Historial::UPDATED # Save only updated values
            values = {}
            item.original_attributes.each { |oa| values[oa[0].name] = oa[1] }
            h.original_state = values.to_json
        end

        h.user_id       = params[:user].id          if params.has_key?(:user) && params[:user]
        h.save
    end

    def historiable=(item, save_state = true)
        throw 'Cannot be null' if item.nil?

        self.historiable_id   = item.id
        self.historiable_type = item.class.to_s

        self.original_date    = item.created_at   if item.saved?
        self.original_state   = item.to_json      if save_state
        
    end

    def historiable
        cls = Kernel.const_get historiable_type
        cls.get historiable_id
    end

end
