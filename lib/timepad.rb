class Timepad

  def user_synchronization
    User.activated.nonsynchronized.find_each do |user|

      uri = URI(configus.timepad.maillist_add_items_url)

      params = {
        code: configus.timepad.api_key,
        id: configus.timepad.organization_id,
        m_id: configus.timepad.maillist_id,
        i0_email: user.email,
        i0_name: user.first_name,
        i0_surname: user.last_name,
      }

      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)
      parsed_response = JSON.parse response.body

      case response.code
      when "200"
        addedItemsCount = parsed_response["itemsAdded"]
        duplicateItemsCount = parsed_response["itemsDuplicate"]

        if (!addedItemsCount.zero? || !duplicateItemsCount.zero?)
          user.synchronize
          puts "User ##{user.id} synchronized with timepad"
        else
          user.failure
          puts "User ##{user.id} nonsynchronized with timepad, response: ##{parsed_response}"
        end

      else
        puts "User ##{user.id} synchronization failed with response: ##{parsed_response}"
      end

    end
  end

end