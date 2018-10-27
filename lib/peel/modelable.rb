require_relative 'repository'

module Peel
  module Modelable
    def initialize(**args)
      args.each do |attribute, value|
        if self.class.columns.include?(attribute)
          instance_variable_set("@#{attribute.to_s}", value)
        else
          raise ArgumentError, "Unknown keyword: #{attribute}"
        end
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def peel_off(table)
        @name = table.to_s
        @repository = Repository.new
        create_accessors
      end

      def create_accessors
        columns.each do |column|
          define_method("#{column}") { instance_variable_get("@#{column}")}
          define_method("#{column}=") { |value| instance_variable_set("@#{column}", value)}
        end
      end

      def find(id)
        result = @repository.execute(
          "SELECT * FROM #{@name} WHERE id = ? LIMIT 1",
          id
        )
        if result.empty?
          {}
        else
          result_hash = columns.zip(result.first).to_h
          new(result_hash)
        end
      end

      def columns
        @repository.execute("PRAGMA table_info(#{@name})")
          .map { |col| col[1].to_sym }
      end
    end
  end
end