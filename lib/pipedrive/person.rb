module Pipedrive
  class Person < Base

    class << self

      def find_or_create_by_name(name, opts={})
        find_by_name(name, :org_id => opts[:org_id]).first || create(opts.merge(:name => name))
      end

      def add_follower(person_id, user_id)
        opts = {user_id: user_id}
        res = post "#{resource_path}/#{person_id}/followers", :body => opts
        res.success? ? res['data']['id'] : bad_response(res,opts)
      end

      def del_follower(person_id, user_id)
        opts = {user_id: user_id}
        res = delete "#{resource_path}/#{person_id}/followers/#{user_id}", :body => opts
        res.success? ? res['data']['id'] : bad_response(res,opts)
      end
    end

    def deals()
      Deal.all(get "#{resource_path}/#{id}/deals", :everyone => 1)
    end

    def activities
      Activity.all(get "#{resource_path}/#{id}/activities")
    end

    def add_follower(user_id)
      opts = {user_id: user_id}
      res = post "#{resource_path}/#{id}/followers", :body => opts
      res.success? ? res['data']['id'] : bad_response(res,opts)
    end

     def add_product(opts = {})
      res = post "#{resource_path}/#{id}/products", :body => opts
      res.success? ? res['data']['product_attachment_id'] : bad_response(res,opts)
    end
  end
end