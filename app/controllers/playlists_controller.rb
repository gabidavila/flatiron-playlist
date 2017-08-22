class PlaylistsController<ApplicationController

  def index
    @playlists = Playlist.all
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user_id = current_user.id
    if @playlist.save
      redirect_to playlist_path(@playlist)
    else
      render :'/playlists/new'
    end
  end

  def show
    @playlist = Playlist.find_by(id: params[:id], user: current_user)
  end

  def destroy
    Playlist.find_by(params[:id]).destroy
    redirect_to playlists_path
  end

  def edit
    @playlist = Playlist.find_by(id: params[:id])
  end

  def update
    @playlist = Playlist.find_by(id: params[:id])
    @playlist.update(playlist_params)
    redirect_to playlist_path(@playlist)
  end

  def add_songs
    @playlist = Playlist.find_by(id: params[:playlist][:id], user: current_user)
    song_ids = params[:playlist][:song_ids].map(&:to_i) + @playlist.song_ids

    if @playlist && @playlist.update(song_ids: song_ids)
      redirect_to playlist_path(@playlist)
    else
      redirect_to songs_path
    end
  end

  private
  def playlist_params
    params.require(:playlist).permit(:name)
  end

end
