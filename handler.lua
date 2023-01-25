local CheckPermissions = require "check_permissions"

return {
  ["pre-function"] = CheckPermissions
}
