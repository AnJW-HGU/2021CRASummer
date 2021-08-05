const cors = require('cors');
const createError = require('http-errors');
const express = require('express');
const path = require('path');
const logger = require('morgan');
const session = require('express-session');
const mysqlStore = require('./models');
const { sequelize } = require('./models');
const cookieParser = require('cookie-parser');
const fileUpload = require('express-fileupload');
const env = process.env.NODE_ENV || 'development';
const config = require(__dirname + '/config/config.js');

// maybe login ?
// const secretKey = require('./config/jwt_secret');
// const passport = require('passport');
// const passportConfig = require('./middlewares/passport');

// sequelize
sequelize
        .authenticate()
        .then(() => { console.log("Connection Success"); })
        .catch((e) => { console.log(e); });
sequelize.sync({}); 

// define router var
const app = express();
const router = require('./routes');

// session store
//const sessionStore = new mysqlStore({
//    host: config.host,
//    port: config.port,
//    user: config.username,
//    password: config.password,
//    database: config.database
//});

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(cors());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));


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
