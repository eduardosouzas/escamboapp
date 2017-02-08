class BackofficeController < ApplicationController
  before_action :authenticate_admin!
  layout "Backoffice"

  def pundit_user
      current_admin # current_user to pundit
  end

end
