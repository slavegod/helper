local http_service = cloneref(game:GetService("HttpService"))

local http = {}

http.send_request = function(url : string, method : string, headers : table, body : table)
    local response = http_request(
        {
            Url = url,
            Method = method,
            Headers = headers,
            Body = http_service:JSONEncode(body)
        }
    )

    if response then
        return response
    end
end

return http 
