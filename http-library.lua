local http_service = cloneref(game:GetService("HttpService"))

local http = {}

http.send_request = function(url : string, method : string, hell)
    local response = http_request(
        {
            Url = url,
            Method = tostring(method),
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = services.http_service:JSONEncode(hell)
        }
    )

    if response then
        return response
    end
end

return http 
