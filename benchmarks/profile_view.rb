# frozen_string_literal: true

require "hotch"
require "pathname"
require "ostruct"
require "hanami/view"

TEMPLATES_PATHS = Pathname(__FILE__).dirname.join("templates")

TEMPLATE_LOCALS = {
  users: [
    OpenStruct.new(name: "Jane", email: "jane@example.com"),
    OpenStruct.new(name: "Teresa", email: "teresa@example.com")
  ]
}.freeze

class View < Hanami::View
  config.paths = TEMPLATES_PATHS
  config.layout = "app"
  config.template = "users"

  expose :users
end

view = View.new

Hotch(filter: "Hanami", options: {limit: 50}) {
  1000.times { view.(**TEMPLATE_LOCALS) }
}
