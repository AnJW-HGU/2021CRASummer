const { User } = require('../models/index');

// nickname
exports.createNickname = async (req, res) => {
	User.findAll({
		where: {nickname: req.body.nickname}
	}).then(result => {
		if(result[0] !== undefined){
			console.log(result)
			res.json({"duplicate":1})
		} else {
			User.update({
			  nickname : req.body.nickname
			  },{
				 where: { id: req.params.userId }
			 }).then(result => {
			 res.json(result);
		    });		
		}
	});
} 

exports.getNickname = async (req, res) => {
    User.findOne({
        where: { id: req.params.userId }
    }).then(result => {
        console.log(result.dataValues.nickname);
        res.json(result.dataValues.nickname)
    })
} 

exports.updateNickname = async (req, res) => {
	User.findAll({
		where: {nickname: req.body.nickname}
	}).then(result => {
		if(result[0] !== undefined){
			console.log(result)
			res.json({"duplicate":1})
		} else {
			User.update({
			  nickname : req.body.nickname
			  },{
				 where: { id: req.params.userId }
			 }).then(result => {
			 res.json(result);
		    });		
		}
	});
}

exports.deleteNickname = async (req, res) => {
    User.update({
        nickname : null
    },{
        where: { id: req.params.userId }
    }).then(result => {
        res.json(result);
    });
}

// points
exports.getPoint = async (req, res) => {
    User.findOne({
        where: { id: req.params.userId }
    }).then(result => {
        console.log(result.dataValues.points);
        res.json(result.dataValues.points)
    })
}

exports.updatePoint = async (req, res) => {
    User.update({
        points : req.body.point
    },{
        where: { id: req.params.userId }
    }).then(result => {
        res.json(result);
    });
}

exports.createUser = async (req, res) => {
	User.create({
		google_id: req.body.googleId,
		student_id : req.body.studentId,
		name: req.body.name,
		email: req.body.email
		}).then(result => {
			res.json(result);
		});
}
