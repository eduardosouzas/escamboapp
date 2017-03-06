class Site::AdDetailController < SiteController

    def show
        @categories = Category.order_by_description
        @ad = Ad.find(params[:id])
        @comments = @ad.comments.limit(3).order(created_at: :desc)
    end
end
