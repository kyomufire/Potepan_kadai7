class RoomsController < ApplicationController
  protect_from_forgery except: [:upload_photo]

  before_action :set_room, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show]
  before_action :authorize_user, only: [:listing, :pricing, :description, :photo_upload, :location, :update]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new

  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      if params[:room][:photos].blank?
        @room.photos.attach(io: File.open(Rails.root.join("app", "assets", "images", "default-room_image.png")), filename: "default-room_image.png", content_type: "image/png")
      end
      flash[:notice]= "保存しました。"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @reservation = Reservation.new
    @photos = @room.photos
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
  end

  def amenities
  end

  def location
  end

  def update

    new_params = room_params
    new_params[:active] = true if is_ready_room

    if @room.update(new_params)
      flash[:notice] = "保存しました。"
    else
      flash[:alert] = "問題が発生しました。"
    end
      redirect_back(fallback_location: request.referrer)
  end

  def upload_photo
    @room.photos.attach(params[:file])
    render json: { success:true }
  end

  def delete_photo
    @image = ActiveStorage::Attacchment.find(params[:photo_id])
    @image.purge
    redirect_to photo_upload_room_path(@room)
  end


  private

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:room_type, :listing_name, :summary, :price, :address, :active, :description, :avatar, :image, photos: [] )
    end

    def authorize_user
      redirect_to root_path, alert:"権限がありません。" unless current_user.id == @room.user_id
    end

    def is_ready_room
      !@room.active && !@room.price.blank? && !@room.listing_name.blank? && !@room.photos.blank? && !@room.address.blank?
    end

    def is_conflict(start_date, end_date, room)
      room.reservations.where("? < start_date AND end_date < ?", start_date, end_date).exists?
    end
end