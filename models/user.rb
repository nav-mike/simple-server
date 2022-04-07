class User
  attr_reader :id, :name, :email

  def initialize(id:, name:, email:)
    super()
    @id, @name, @email = id, name, email
  end

  def to_h()= { id: @id, name: @name, email: @email }
end
