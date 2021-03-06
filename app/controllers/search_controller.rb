class SearchController < ApplicationController
  def index
    @feeds = Feed.order('rank DESC').paginate(page: params[:page], per_page: 12)
    respond_to do |format|
      format.html { render_by_device }
      format.js { render 'search/s_search_mobile' }
    end
  end

  # keyword : feed.title, upcoming.title, artist.name, user.nickname, upcoming.place
  def result
    @search = params[:search]
    if current_user
      # 같은 검색어가 목록에 여럿 있는 경우를 막기 위해 있으면 삭제
      prev = current_user.recent_keywords.where('keyword', @search)
      if prev.count > 0
        prev.take.destroy
      end
      key = RecentKeyword.new
      key.keyword = @search
      key.user_id = current_user.id
      key.save
    end

    @feed_results = Feed.search(
      @search,
      fields: [:artists_names, :title, :user_nickname],
      operator: "or",
      match: :word_middle
    )
    @upcoming_results = Upcoming.search(
      @search,
      fields: [:artists_names, :title, :place],
      operator: "or",
      match: :word_middle
    )
    @result_size = @feed_results.size + @upcoming_results.size
    render_by_device
  end

  # Should return an array of strings
  def autocomplete
    key = params[:key]
    feeds = Feed.select('title').where('title LIKE ?', "%#{key}%").limit(5).map { |f| f.title }
    upcomings = Upcoming.select('title').where('title LIKE ?',"%#{key}%").limit(5).map { |u| u.title }
    artists = Artist.select('name').where('name LIKE ?',"%#{key}%").limit(5).map { |u| u.name }
    result = feeds + upcomings + artists

    respond_to do |format|
      format.json { render json: result.shuffle }
    end
  end

  def clear_history
    if current_user
      current_user.recent_keywords.destroy_all
    else
      puts "Error"
    end
  end

end
