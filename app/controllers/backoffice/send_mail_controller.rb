class Backoffice::SendMailController < BackofficeController

def edit
    @admin = Admin.find(params[:id])
end

def create

end
end
