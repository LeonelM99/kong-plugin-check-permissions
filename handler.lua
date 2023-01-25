local CheckPermissions = require "kong.plugins.check_permissions.check_permissions"

return {
  ["pre-function"] = CheckPermissions
}