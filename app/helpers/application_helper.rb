module ApplicationHelper

    def avatar_url(object)
        if object.is_a?(User)
            user_avatar_url(object)
        elsif object.is_a?(Room)
            room_avatar_url(object)
        end
    end

    def user_avatar_url(user)
        if user.avatar_attached?
            url_for(user.avatar)
        elsif user.image?
            user.image
        else
            ActionController::Base.helpers.asset_path("icon_default_avatar.jpg")
        end
    end

    def room_avatar_url(room)
        if room.avatar_attached?
            url_for(room.avatar)
        else
            ActionController::Base.helpers.asset_path("default_image_room.png")
        end
    end
end
