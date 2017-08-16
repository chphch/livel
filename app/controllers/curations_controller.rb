class CurationsController < ApplicationController
  def show
    @curation = Curation.find_by(id: params[:id])
    @curation.increase_count_view
    @like_true = user_signed_in? && CurationLike.where(curation_id: params[:id], user_id: current_user.id).take
    @disable_nav = true
    render_by_device
  end

  def toggle_like
    if user_signed_in?
      curation = Curation.find(params[:curation_id])
      @like_true = CurationLike.toggle_like(curation, current_user)
      @like_type = "like"
      @like_count = curation.curation_likes.size
      @video_index = params[:video_index]
      render '/xhrs/create_like'
    else
      render '/xhrs/login_modal'
    end
  end

  def update
    @curation = Curation.find(params[:id])
    if @curation.update(title: params[:title], youtube_id: params[:youtube_id], content: params[:content])
      redirect_back(fallback_location: root_path)
    else
      render text: @curation.errors.messages
    end
  end

  def destroy
    if Curation.destroy(params[:id])
      redirect_back(fallback_location: root_path)
    else
      render text: @curation.errors.messages
    end
  end
end
