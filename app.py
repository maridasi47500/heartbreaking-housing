from flask import Flask, render_template, request, session
import os
from yourappdb import query_db, get_db
from flask import g

app = Flask(__name__)
app.secret_key="any string"
def init_db():
    with app.app_context():
        db = get_db()
        with app.open_resource('schema.sql', mode='r') as f:
            db.cursor().executescript(f.read())
        db.commit()
init_db()

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

@app.route("/")
def hello_world():
    user = query_db('select * from contacts')
    the_username = "anonyme"
    one_user = query_db('select * from contacts where first_name = ?',
                [the_username], one=True)
    return render_template("hey.html", users=user, one_user=one_user, the_title="my title")
@app.route("/add_one_user", methods=["GET","POST"])
def add_one_user():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)


        touslescountry-id= query_db("select * from country-id")

        one_user = query_db("insert into user (username,email,password,phone,country-id) values (:username,:email,:password,:phone,:country-id)",hey)
        user = query_db('select * from user')

        last_user = query_db("select * from user where email = ? and password = ?",[hey["email"], hey["password"]], one=True)
        session["current_user_id"]=last_user["id"]
        for x in ['username','email','password','phone','country-id']:
            session[x]=hey[x]


        return render_template("userform.html", users=user, one_user=one_user, the_title="add new user", touslescountry-id=touslescountry-id)


    touslescountry-id= query_db("select * from country-id")

    user = query_db('select * from user')
    one_user = query_db("select * from user limit 1", one=True)
    return render_template("userform.html", users=user, one_user=one_user, the_title="add new user", touslescountry-id=touslescountry-id)


@app.route("/user_sign_out", methods=["GET","POST"])
def user_sign_out():
    if request.method == 'POST':
        session["current_user_id"]=""
        for x in ['username','email','password','phone','country-id']:
            session[x]=""
        return redirect("/")


@app.route("/user_log_in", methods=["GET","POST"])
def user_login():
    if request.method == 'POST':
        hey=request.form
        last_user = query_db("select * from user where email = ? and password = ?",[hey["email"], hey["password"]], one=True)
        try:
            session["current_user_id"]=last_user["id"]
            for x in ['username','email','password','phone','country-id']:
                session[x]=hey[x]
        except:
            return render_template("userlogin.html")
    return render_template("userlogin.html")
@app.route("/add_one_language", methods=["GET","POST"])
def add_one_language():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)


        one_user = query_db("insert into language (name,shortname) values (:name,:shortname)",hey)
        user = query_db('select * from language')

        return render_template("languageform.html", languages=user, one_user=one_user, the_title="add new language")


    user = query_db('select * from language')
    one_user = query_db("select * from language limit 1", one=True)
    return render_template("languageform.html", languages=user, one_user=one_user, the_title="add new language")

@app.route("/add_one_habitationhasvideo", methods=["GET","POST"])
def add_one_habitationhasvideo():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)

        uploaded_file = request.files['video']
        if uploaded_file.filename != '':
            uploaded_file.save(os.path.join('static/photos', uploaded_file.filename))

        hey["video"]=uploaded_file.filename


        one_user = query_db("insert into habitationhasvideo (video) values (:video)",hey)
        user = query_db('select * from habitationhasvideo')

        return render_template("habitationhasvideoform.html", habitationhasvideos=user, one_user=one_user, the_title="add new habitationhasvideo")


    user = query_db('select * from habitationhasvideo')
    one_user = query_db("select * from habitationhasvideo limit 1", one=True)
    return render_template("habitationhasvideoform.html", habitationhasvideos=user, one_user=one_user, the_title="add new habitationhasvideo")

@app.route("/add_one_userhaswaypoints", methods=["GET","POST"])
def add_one_userhaswaypoints():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)


        one_user = query_db("insert into userhaswaypoints (lat,Lon,placename,city,sea) values (:lat,:Lon,:placename,:city,:sea)",hey)
        user = query_db('select * from userhaswaypoints')

        return render_template("userhaswaypointsform.html", userhaswaypointss=user, one_user=one_user, the_title="add new userhaswaypoints")


    user = query_db('select * from userhaswaypoints')
    one_user = query_db("select * from userhaswaypoints limit 1", one=True)
    return render_template("userhaswaypointsform.html", userhaswaypointss=user, one_user=one_user, the_title="add new userhaswaypoints")

@app.route("/add_one_waypointhasmeal", methods=["GET","POST"])
def add_one_waypointhasmeal():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)


        tousleswaypoint= query_db("select * from waypoint")

        one_user = query_db("insert into waypointhasmeal (title,content,waypoint_id) values (:title,:content,:waypoint_id)",hey)
        user = query_db('select * from waypointhasmeal')

        return render_template("waypointhasmealform.html", waypointhasmeals=user, one_user=one_user, the_title="add new waypointhasmeal", tousleswaypoint=tousleswaypoint)


    tousleswaypoint= query_db("select * from waypoint")

    user = query_db('select * from waypointhasmeal')
    one_user = query_db("select * from waypointhasmeal limit 1", one=True)
    return render_template("waypointhasmealform.html", waypointhasmeals=user, one_user=one_user, the_title="add new waypointhasmeal", tousleswaypoint=tousleswaypoint)

@app.route("/add_one_mealhasuser", methods=["GET","POST"])
def add_one_mealhasuser():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)


        one_user = query_db("insert into mealhasuser (user_id,meal_id) values (:user_id,:meal_id)",hey)
        user = query_db('select * from mealhasuser')

        return render_template("mealhasuserform.html", mealhasusers=user, one_user=one_user, the_title="add new mealhasuser")


    user = query_db('select * from mealhasuser')
    one_user = query_db("select * from mealhasuser limit 1", one=True)
    return render_template("mealhasuserform.html", mealhasusers=user, one_user=one_user, the_title="add new mealhasuser")

@app.route("/add_one_waypointhaspeopleyouknow", methods=["GET","POST"])
def add_one_waypointhaspeopleyouknow():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)


        one_user = query_db("insert into waypointhaspeopleyouknow (user_id,waypoint_id) values (:user_id,:waypoint_id)",hey)
        user = query_db('select * from waypointhaspeopleyouknow')

        return render_template("waypointhaspeopleyouknowform.html", waypointhaspeopleyouknows=user, one_user=one_user, the_title="add new waypointhaspeopleyouknow")


    user = query_db('select * from waypointhaspeopleyouknow')
    one_user = query_db("select * from waypointhaspeopleyouknow limit 1", one=True)
    return render_template("waypointhaspeopleyouknowform.html", waypointhaspeopleyouknows=user, one_user=one_user, the_title="add new waypointhaspeopleyouknow")

@app.route("/add_one_waypointhasforeignlanguage", methods=["GET","POST"])
def add_one_waypointhasforeignlanguage():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)


        one_user = query_db("insert into waypointhasforeignlanguage (user_id,language_id) values (:user_id,:language_id)",hey)
        user = query_db('select * from waypointhasforeignlanguage')

        return render_template("waypointhasforeignlanguageform.html", waypointhasforeignlanguages=user, one_user=one_user, the_title="add new waypointhasforeignlanguage")


    user = query_db('select * from waypointhasforeignlanguage')
    one_user = query_db("select * from waypointhasforeignlanguage limit 1", one=True)
    return render_template("waypointhasforeignlanguageform.html", waypointhasforeignlanguages=user, one_user=one_user, the_title="add new waypointhasforeignlanguage")

@app.route("/add_one_waypointhasconcert", methods=["GET","POST"])
def add_one_waypointhasconcert():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)

        uploaded_file = request.files['pic']
        if uploaded_file.filename != '':
            uploaded_file.save(os.path.join('static/photos', uploaded_file.filename))

        hey["pic"]=uploaded_file.filename


        one_user = query_db("insert into waypointhasconcert (waypoint_id,title,pic,date) values (:waypoint_id,:title,:pic,:date)",hey)
        user = query_db('select * from waypointhasconcert')

        return render_template("waypointhasconcertform.html", waypointhasconcerts=user, one_user=one_user, the_title="add new waypointhasconcert")


    user = query_db('select * from waypointhasconcert')
    one_user = query_db("select * from waypointhasconcert limit 1", one=True)
    return render_template("waypointhasconcertform.html", waypointhasconcerts=user, one_user=one_user, the_title="add new waypointhasconcert")

@app.route("/add_one_waypointhassocialmediapost", methods=["GET","POST"])
def add_one_waypointhassocialmediapost():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)


        one_user = query_db("insert into waypointhassocialmediapost (user_id,title,content) values (:user_id,:title,:content)",hey)
        user = query_db('select * from waypointhassocialmediapost')

        return render_template("waypointhassocialmediapostform.html", waypointhassocialmediaposts=user, one_user=one_user, the_title="add new waypointhassocialmediapost")


    user = query_db('select * from waypointhassocialmediapost')
    one_user = query_db("select * from waypointhassocialmediapost limit 1", one=True)
    return render_template("waypointhassocialmediapostform.html", waypointhassocialmediaposts=user, one_user=one_user, the_title="add new waypointhassocialmediapost")

@app.route("/add_one_userhashabitation", methods=["GET","POST"])
def add_one_userhashabitation():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)


        one_user = query_db("insert into userhashabitation (user_id,habitation_id) values (:user_id,:habitation_id)",hey)
        user = query_db('select * from userhashabitation')

        return render_template("userhashabitationform.html", userhashabitations=user, one_user=one_user, the_title="add new userhashabitation")


    user = query_db('select * from userhashabitation')
    one_user = query_db("select * from userhashabitation limit 1", one=True)
    return render_template("userhashabitationform.html", userhashabitations=user, one_user=one_user, the_title="add new userhashabitation")

@app.route("/add_one_habitationhasjob", methods=["GET","POST"])
def add_one_habitationhasjob():

    if request.method == 'POST':

        the_username = "anonyme"
        hey=dict(request.form)


        one_user = query_db("insert into habitationhasjob (job_id,user_id,habitation_id) values (:job_id,:user_id,:habitation_id)",hey)
        user = query_db('select * from habitationhasjob')

        return render_template("habitationhasjobform.html", habitationhasjobs=user, one_user=one_user, the_title="add new habitationhasjob")


    user = query_db('select * from habitationhasjob')
    one_user = query_db("select * from habitationhasjob limit 1", one=True)
    return render_template("habitationhasjobform.html", habitationhasjobs=user, one_user=one_user, the_title="add new habitationhasjob")

