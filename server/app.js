const cors = require('cors');
const createError = require('http-errors');
const express = require('express');
const path = require('path');
const logger = require('morgan');
const cookieParser = require('cookie-parser');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const { sequelize } = require('./models');
const fileUpload = require('express-fileupload');
const env = process.env.NODE_ENV || 'development';
const config = require(__dirname + '/config/config.json')[env];
const passport = require('passport');
// maybe login ?
// const secretKey = require('./config/jwt_secret');
// const passport = require('passport');
// const passportConfig = require('./middlewares/passport');

// sequelize
sequelize
        .authenticate()
        .then(() => { console.log("Connection Success"); })
        .catch((e) => { console.log(e); });
sequelize.sync(); 

// define router var
const app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(cors());
app.use(logger('dev'));
app.use(cookieParser('asdfghjkl'));

const sessionStore = new MySQLStore({
    host: config.host,
    port: config.port,
    user: config.username,
    password: config.password,
    database: config.database
});

const grabController = require('./controllers/grab');
grabController.main();

app.use(session({
	secret: "asdfghjkl",
	resave: false,
	saveUninitialized: true,
	store: sessionStore,
	cookie: {
		secure: false,
		httpOnly: false,
		maxAge: 1000 * 60 * 2
	}
}));

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.urlencoded({ extended: false }));
app.use(passport.initialize());
app.use(passport.session());

const router = require('./routes');
app.use('/', router);

// TODO: initialize express-session to allow us track the logged-in user across sessions.

// use router var
//app.use('/', indexRouter);
//app.use('/users', userRouter);

// catch 404 and forward to error handler


app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

app.listen(3000, function () {
  console.log('app listening on port 3000!');
});

module.exports = app;
