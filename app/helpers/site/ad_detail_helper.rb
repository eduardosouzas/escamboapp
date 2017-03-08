module Site::AdDetailHelper
    def post_date(date)
    # formatting date: Aug, 31 2007 - 9:55PM
    date.strftime("postado em %b, %m %Y - %H:%M")
  end
  def rating_for_user(rateable_obj, rating_user, dimension = nil, options = {})
      @object = rateable_obj
      @user = rating_user
      @rating = Rate.find_by_rater_id_and_rateable_id_and_dimension(@user.id, @object.id, dimension)
      star = options[:star] || 5
      stars = @rating ? @rating.stars : 0

      disable_after_rate = options[:disable_after_rate] || false

      readonly=false
      if disable_after_rate
        readonly = current_user.present? ? !rateable_obj.can_rate?(current_user.id, dimension) : true
      end

      content_tag :div, '', "data-dimension" => dimension, :class => "star", "data-rating" => stars,
      "data-id" => rateable_obj.id, "data-classname" => rateable_obj.class.name,
      "data-disable-after-rate" => true,
      "data-readonly" => true,
      "data-star-count" => star
    end

end
