require_relative '../models/user'

require 'json'

module CreateUser
  extend self

  def create_user(params)
    params => email:, name:

    return { error: 'Missing email' } if email.nil?
    return { error: 'Missing name' } if name.nil?

    user = User.new(id: Time.now.to_i, email:, name:)

    { ok: user }
  end

  def call(env)
    case create_user(params(env))
      in { error: message }
        [400, { 'Content-Type' => 'application/json' }, [{ error: message }.to_json]]
      in { ok: user }
        [200, { 'Content-Type' => 'application/json' }, [{ user: user.to_h }.to_json]]
    end
  end
  
  private
  
  def params(env)
    Hash[JSON.parse(Rack::Request.new(env).body.read).map{ |k, v| [k.to_sym, v] }]
  end
end
