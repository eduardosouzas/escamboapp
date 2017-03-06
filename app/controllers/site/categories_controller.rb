class Site::CategoriesController < SiteController


    def show
        @categories = Category.order_by_description
        @ads = Category.friendly.find(params[:id]).ads.page(params[:page]).per(6)
    end
end
