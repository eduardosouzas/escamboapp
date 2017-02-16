class Backoffice::SendMailController < BackofficeController

    def edit
        @admin = Admin.find(params[:id])
    end

    def create
      begin
        AdminMailer.send_message(current_admin,params["recipient-text"],params["subject-text"],params["message-text"]).deliver_now
        @notify_message = "Email enviado com sucesso para " << params["recipient-name"]
        @notify_flag = "success"
      rescue
        @notify_message = "erro ao enviar o email, tente novamente"
        @notify_flag = "error"
      end
      respond_to do |format|
        format.js

      end


    end
end
