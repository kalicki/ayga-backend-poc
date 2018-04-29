module Api::Controllers::Users
  class Index
    include Api::Action

    def call(params)
      self.body = 'OK'
    end
  end
end
