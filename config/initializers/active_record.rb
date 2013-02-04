module ActiveRecord
  module Inheritance
    extend ActiveSupport::Concern

    module ClassMethods

      # Monkey patch https://github.com/rails/rails/blob/master/activerecord/lib/active_record/inheritance.rb
      # Необходим для изменения поведения метода becomes при использовании STI
      # Данный патч позволяет с помощью метода becomes производить мутацию объекта и позволяет сохранять результат в БД
      # Пример использования без патча: 
      #   @member = Member.first                        #member.sti_name = "Member"
      #   @speaker = User.find(@member.id)              #speaker.sti_name = "Member"
      #   @speaker = @speaker.becomes(SpeakerEditType)  #speaker.sti_name = "Speaker"
      #   @speaker.update_attributes(password: "12345") #update НЕ ПРОИЗОЙДЕТ, ибо получится запрос вида
      #     UPDATE "users" 
      #     SET "type" = 'Speaker', "password" = '12345' 
      #     WHERE "users"."type" IN ('Speaker')   !!! А в БД тип все еще "Member" 
      #     AND "users"."id" = *

      # Пример использования c патчем:
      #   @member = Member.first                        #member.sti_name = "Member"
      #   @speaker = User.find(@member.id)              #speaker.sti_name = "Member"
      #   @speaker = @speaker.becomes(SpeakerEditType)  #speaker.sti_name = "Speaker"
      #   @speaker.update_attributes(password: "12345") #update БУДЕТ УСПЕШНЫМ, ибо получится запрос вида
      #     UPDATE "users" 
      #     SET "type" = 'Speaker', "password" = '12345' 
      #     WHERE "users"."id" = *


      def type_condition(table = arel_table)
        # sti_column = table[inheritance_column.to_sym]
        # sti_names  = ([self] + descendants).map { |model| model.sti_name }
        # sti_column.in(sti_names)
      end
      
    end

  end
end