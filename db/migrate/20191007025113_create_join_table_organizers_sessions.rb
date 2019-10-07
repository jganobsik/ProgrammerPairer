class CreateJoinTableOrganizersSessions < ActiveRecord::Migration[6.0]
  def change
    create_join_table :organizers, :sessions do |t|
       t.index [:organizer_id, :session_id]
       t.index [:session_id, :organizer_id]
    end
  end
end
