class Application
    @@items = [Item.new("name_1", 1.23), Item.new("name_2",3.02)]
    
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        
        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            if item = @@items.find{|item| item.name == item_name}
                resp.write item.price
            else
                resp.status = 400
                resp.write "Item not found"
            end
        else
            return[404, {'Content-Type' => 'text/html'}, ["Route not found"]]
        end
        resp.finish

    end

end