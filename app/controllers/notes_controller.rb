class NotesController < ApplicationController
    def index
        notes = Note.all
        render json: notes
    end

    def create
        note = Note.new(note_params)
        if note.save
            render json: note
        else
            render json: {"message": "note couldn't be created."}
        end
    end

    def update
        note = Note.find(params[:id])
        if note.update_attributes(note_params)
            render json: note
        else
            render json: {"message": "Something went wrong!"}
        end
    end

    def destroy
        note = Note.find(params[:id])
        if note.destroy
            render json: note
        else
            render json: {"message": "Couldn't delete note."}
        end
    end

    private
    
    def note_params
        params.require(:note).permit(:content, :date)
    end
end
