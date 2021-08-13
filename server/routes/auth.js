const { Router } = require('express');
const { User } = require(__dirname + '/../models');
const session = require('express-session');
const router = Router();
const authController = require('../controllers/auth');
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const { google } = require('googleapis')
const MySQLStore = require('express-mysql-session')(session);
const env = process.env.NODE_ENV || 'development';
const config = require(__dirname + '/../config/config.json')[env]

const GOOGLE_CLIENT_ID = "195470571341-alkmg5ng2aj9gkqnug0rpps3f9oioshj.apps.googleusercontent.com"
const GOOGLE_CLIENT_SECRET = "YfI3qg4wYdq9qW_iWXZKFFV7";
const GOOGLE_REDIRECT_URL = "http://128.199.139.159.nip.io:3000/auth/callback"


const oauth2Client = new google.auth.OAuth2(
	GOOGLE_CLIENT_ID,
	GOOGLE_CLIENT_SECRET,
	GOOGLE_REDIRECT_URL
);

const scopes = [
	'email',
	'profile'
];

const url = oauth2Client.generateAuthUrl({
	access_type: 'offline',
	scope: scopes,
	flowName: 'GeneralOAuthFlow',
	approval_prompt: 'force'
});

passport.serializeUser((user, done) => {
    done(null, user.id);
});

var user_id;

passport.deserializeUser((id, done) => {
	console.log("User access");
	//user_id = user.id;
	done(null, id)
})

passport.use(new GoogleStrategy(
  {
    clientID: GOOGLE_CLIENT_ID,
    clientSecret: GOOGLE_CLIENT_SECRET,
    callbackURL: GOOGLE_REDIRECT_URL,
    state: false,
  },(accessToken, refreshToken, profile, cb) => {
		User.findOrCreate({
			where: {google_id: profile.id},
			defaults:{
			google_id: profile.id,
			name: profile.displayName,
			email: profile.emails[0].value,
			student_id: profile.emails[0].value.split('@')[0]
		}})	
	return cb(null, profile);
  }
));

router.get('/', function(req, res){
	res.send(url);
});

router.get('/callback', passport.authenticate("google", {
  failureRedirect: "/auth/fail",
}), (req, res) => {
  console.log("Success redirect");
  res.redirect('/auth/success')
});

router.get('/success', function(req, res){
	res.json({"login": true});
	console.log("succes: " + req.user);
	if(req.session.passport)
		user_id = req.user
});

router.get('/fail', function(req, res){
	res.json({"login": false})
});

router.get('/load', function(req, res){
	if(user_id !== undefined){
		User.findOne({
			where:{google_id: user_id}
		}).then(result => {
			if(result)
				res.json(result.id)
			else
				res.json({"login": false})
		})
	} else {
		res.json({"login": false});
	}
});



module.exports = router;
