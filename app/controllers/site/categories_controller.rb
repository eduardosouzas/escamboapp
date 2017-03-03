class Site::CategoriesController < SiteController


    def show
        @categories = Category.order_by_description
        @ads = Category.friendly.find(params[:id]).ads
    end
end
