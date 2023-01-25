return {
    fields = {
        expected_permissions = { type = "table", required = true, fields = {
                                  [{permission = { type = "string"}},
                                   {method = { type = "string", one_of = { "GET", "POST", "PUT" } } }]
                                } }
    }
}