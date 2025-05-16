module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def authorize!(action, subject)
      ability = Ability.new(context[:current_user])
      unless ability.can?(action, subject)
        raise GraphQL::ExecutionError, "You are not authorized to perform this action"
      end
    end
  end
end
