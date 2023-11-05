tl = create_timeline("Mine")
puts tl #=> {"name"=>"Mine", "color"=>"#ae2d1b", "scope"=>"DEFAULT", "updated_at"=>1698763720728596964}
tls = list_timelines()
check_expression("#{tls.length} == 1")
puts tls[0] #=> {"name"=>"Mine", "color"=>"#ae2d1b", "scope"=>"DEFAULT", "updated_at"=>1698763720728596964}
delete_timeline("Mine")
check_expression("#{list_timelines().length} == 0")

create_timeline("Mine")
set_timeline_color("Mine", "#4287f5")
puts get_timeline("Mine") #=> {"name"=>"Mine", "color"=>"#4287f5", "scope"=>"DEFAULT", "updated_at"=>1698763720728596964}

now = Time.now()
start = Time.new(now.year, now.month, now.day, now.hour + 1, 30, 00)
stop = start + 3600 # Stop plus 1hr
act = create_timeline_activity("Mine", kind: "reserve", start: start, stop: stop)
puts act #=>
# { "name"=>"Mine", "updated_at"=>1698763721927799173, "fulfillment"=>false, "duration"=>3600,
#   "start"=>1698764400, "stop"=>1698768000, "kind"=>"reserve",
#   "events"=>[{"time"=>1698763721, "event"=>"created"}], "data"=>{"username"=>""} }
# Get activities in the past ... should be none
tlas = get_timeline_activities("Mine", start: Time.now() - 3600, stop: Time.now())
check_expression("#{tlas.length} == 0")
# Get all activities
tlas = get_timeline_activities("Mine")
check_expression("#{tlas.length} == 1")

# Create and delete a new activity
start = start + 7200
stop = start + 300
act = create_timeline_activity("Mine", kind: "reserve", start: start, stop: stop)
tlas = get_timeline_activities("Mine")
check_expression("#{tlas.length} == 2")
delete_timeline_activity("Mine", act['start'])
tlas = get_timeline_activities("Mine")
check_expression("#{tlas.length} == 1")

# delete fails since the timeline has activities
delete_timeline("Mine") #=> RuntimeError : Failed to delete timeline due to timeline contains activities, must force remove
# Force delete since the timeline has activities
delete_timeline("Mine", force: true)
tls = list_timelines()
check_expression("#{tls.length} == 0")
