local CheckPermissions = require "kong-plugin-check-permissions"

return {
  ["pre-function"] = CheckPermissions
}
