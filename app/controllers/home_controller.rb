class HomeController < ApplicationController

  def index
    # Get users that are in logged in user's organization
    @users = current_user.organization.users
  end

  def give_kudo
    @recipient_id = params[:recipient_id]
    @max_kudos_message = false
    current_user.give_kudos(@recipient_id, params[:message])
    @kudos_given = current_user.kudos_given_by_user_in_past_week(@recipient_id)
    @total_kudos_given = current_user.kudos_given_by_user_in_past_week
    if @total_kudos_given >= User::MAX_WEEKLY_KUDOS
      @max_kudos_message = true
    end
    respond_to do |format|
      format.js
    end
  end
end
