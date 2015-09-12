class EventsController < ApplicationController
  def destroy
    match = Match.find(params[:id])
    event = match.events.find(params[:event_id])

    if event.destroy
      match.save
    end

    redirect_to controller: "matches", action: 'show', id: match.id
  end
end