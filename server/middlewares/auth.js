const passport = require("passport");
const secret = require('../config/secret');
const jwt = require('jsonwebtoken');

exports.isLoggedIn = (req, res, next) => {
	const token = req.headers['x-access-token'] || req.query.token;
	if ( !token ) {
		return res.status(403).json({
			success : false,
			message : 'Login first!'
		});
	}
	const promise = new Promise( (resolve, reject) => {
		jwt.verify( // token, secret, [callback]
			token,
			secret.secret,
			(err, decodeed) => {
				if ( err ) reject(err);
				resolve(decodeed);
			}
		);
	});
	const respond = (token) => {
//		res.json({
//			success : true,
//			info : token
//		});
		next();
	};
	const onError = (error) => {
		res.status(403).json({
			success : false,
			message : error.message
		});
	};	
	
	promise
	.then(respond)
	.catch(onError);
}
