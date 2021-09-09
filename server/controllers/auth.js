const { User } = require('../models');
const sequelize = require('sequelize');
const Op = sequelize.Op;
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const { google } = require('googleapis');


const GOOGLE_CLIENT_ID = "195470571341-alkmg5ng2aj9gkqnug0rpps3f9oioshj.apps.googleusercontent.com"
const GOOGLE_CLIENT_SECRET = "YfI3qg4wYdq9qW_iWXZKFFV7";
const GOOGLE_REDIRECT_URL = "http://128.199.139.159.nip.io:3000/auth/callback"
//generating google auth url

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

/*
passport.serializeUser((user, done) => {
  console.log("Login success");
  console.log(user);
  done(null, user.id);
});

passport.deserializeUser((user, done) => {
  console.log("User access");
  done(null, user);
})
*/

passport.use(new GoogleStrategy(
  {
    clientID: GOOGLE_CLIENT_ID,
    clientSecret: GOOGLE_CLIENT_SECRET,
    callbackURL: "http://128.199.139.159.nip.io:3000/auth/callback",
    // callbackURL:"urn:ietf:wg:oauth:2.0:oob",
    state: false,
  },(accessToken, refreshToken, profile, cb) => {

    return cb(null, profile);
  }
));

exports.createUser = async (req, res) => {
	res.send(url);
};

/*
exports.authCallback = async (req, res) => {
	passport.authenticate("google", {
		 failureRedirect: "/login",
	}), (req, res) => {
		console.log("Success redirect");
		res.redirect('/main')
	}
}
*/

exports.authSuccess = async (req, res) => {
	res.json({"login":"success"});
}

exports.authFail = async (req, res) => {
	res.json({"login":"fail"});
}
