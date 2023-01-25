local function check_permission(permission, expected_permissions)
    local header_value = kong.request.get_header("x-payload-permissions")
    if header_value ~= nil and string.find(header_value, permission) and expected_permissions[permission] then
        return true
    else
        return false, { status = 403, message = "Permission denied" }
    end
end

local function check_method(permission, expected_permissions)
    local route_method = kong.request.get_method()
    if expected_permissions[permission] == "GET" and route_method == "GET" then
        return true
    elseif expected_permissions[permission] == "POST" and route_method == "POST" then
        return true
    elseif expected_permissions[permission] == "PUT" and route_method == "PUT" then
        return true
    else
        return false, { status = 405, message = "Method not allowed" }
    end
end

function check_route_permissions(config)
    local expected_permissions = config.expected_permissions
    local header_permissions = string.split(kong.request.get_header("x-payload-permissions"), ',')
    for i = 1, #header_permissions do
        local has_perm, err = check_permission(header_permissions[i], expected_permissions)
        if not has_perm then
            return kong.response.exit(err.status, { message = err.message })
        end
        local is_valid_method, err = check_method(header_permissions[i], expected_permissions)
        if not is_valid_method then
            return kong.response.exit(err.status, { message = err.message })
        end
    end
end

return check_route_permissions
