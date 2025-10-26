
class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  
  # GET /movies or /movies.json
  def index
    @movies = Movie.order(created_at: :desc).page(params[:page]).per(6)
  end
  
  # GET /movies/1 or /movies/1.json
  def show
  end
  
  # GET /movies/new
  def new
    @movie = Movie.new
  end
  
  # GET /movies/1/edit
  def edit
  end
  
  def authorize_user!
    redirect_to movies_path, alert: "Você não tem permissão para editar este filme." unless @movie.user == current_user
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: "Filme adicionado com sucesso." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: "Filme atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to movies_path, notice: "Filme excluido com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def authorize_user!
    return if @movie.user == current_user

    redirect_to movies_path, alert: "Você não tem permissão para alterar este filme."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.expect(movie: [ :title, :synopsis, :release_year, :duration, :director, :user_id ])
    end
end
