class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      resp.write cart_page
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      resp.write handle_add(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def cart_page
    if @@cart.empty?
      "Your cart is empty"
    else
      @@cart.collect{|item| "#{item}\n"}.join("")
    end
  end

  def handle_add(search_term)
    if @@items.include?(search_term)
      @@cart << search_term
      "added #{search_term}"
    else
      "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      "#{search_term} is one of our items"
    else
      "Couldn't find #{search_term}"
    end
  end
end
