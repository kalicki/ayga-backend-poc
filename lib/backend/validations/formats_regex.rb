require 'hanami/validations'

module FormatsRegex
  def self.uuid
    /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/x
  end

  def self.email
    /@/
  end
end