json.id    @event.id
json.title @event.title
json.description @event.description
json.happening @event.happening
json.project_id @event.project ? @event.project.id : nil
json.users @event.users.collect { |u| u.id }
