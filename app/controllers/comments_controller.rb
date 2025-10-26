class CommentsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.build(comment_params)
    @comment.user = current_user if user_signed_in?

    if @comment.save
      redirect_to movie_path(@movie), notice: "Comentário adicionado com sucesso!"
    else
      redirect_to movie_path(@movie), alert: "Erro ao enviar comentário. Verifique os campos."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :content)
  end
end
