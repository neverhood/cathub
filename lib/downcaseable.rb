module ActiveRecord
  class Base
    def downcases *attrs
      after_initialize do
        attrs.each { |attr| send(:"#{attr}=", UnicodeUtils.downcase(send(attr))) if not persisted? and send(attr).present? }
      end
    end
  end
end
