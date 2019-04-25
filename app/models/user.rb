class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :organization

  MAX_WEEKLY_KUDOS = 3

  # Get total kudos given by user in the current week
  # Note: current weeks start Sunday morning at midnight
  # If recipient_id param included, only include those given to specific recipient
  def kudos_given_by_user_in_past_week(recipient_id=nil)
    today = Date.today
    last_sunday = today.prev_occurring(:sunday)
    if recipient_id
      return Kudo.where("given_by_id = ? and given_to_id = ? and date(created_at) >= ?", self.id, recipient_id, last_sunday).count
    else
      return Kudo.where("given_by_id = ? and date(created_at) >= ?", self.id, last_sunday).count
    end
  end

  # Give a kudo to another user
  def give_kudos(recipient_id, message)
    if self.kudos_given_by_user_in_past_week < MAX_WEEKLY_KUDOS
      begin
        Kudo.create(given_by_id: self.id, given_to_id: recipient_id, message: message)
        return true
      rescue Exception => e
        raise "There was a problem creating a kudo"
      end
    end
    return false
  end

  # Get all my kudos
  def get_kudos
    return Kudo.where(given_to: self.id)
  end

  # Can I give kudos right now?
  def can_give_kudos?
    if self.kudos_given_by_user_in_past_week < MAX_WEEKLY_KUDOS
      return true
    end
    return false
  end
end
