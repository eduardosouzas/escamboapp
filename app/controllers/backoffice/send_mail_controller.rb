class Backoffice::SendMailController < BackofficeController

    def edit
        @admin = Admin.find(params[:id])
    end

    def create
      respond_to do |format|
        format.js

      end


    end
end
