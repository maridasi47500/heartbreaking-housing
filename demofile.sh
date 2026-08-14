
mkdir templates 
python3 scaffold.py user username email password phone country-id:references
python3 scaffold.py language name shortname
python3 scaffold.py habitationhasvideo video:file
python3 scaffold.py userhaswaypoints lat Lon placename city:radio sea:radio
python3 scaffold.py waypointhasmeal title content waypoint_id:references
python3 scaffold.py mealhasuser user_id meal_id
python3 scaffold.py waypointhaspeopleyouknow user_id waypoint_id
python3 scaffold.py waypointhasforeignlanguage user_id language_id
python3 scaffold.py waypointhasconcert waypoint_id title pic:file date
python3 scaffold.py waypointhassocialmediapost user_id title content
python3 scaffold.py userhashabitation user_id habitation_id
python3 scaffold.py habitationhasjob job_id user_id habitation_id
