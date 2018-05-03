module Api::Controllers::Accounts
  class Signout
    include Api::Action

    def call(params)
      self.body = 'OK'
    end
  end
end
