const { Recomment } = require('../models/index');
const { User } = require('../models');
const { Post } = require('../models');
const { Comment } = require('../models');
const sequelize = require('sequelize');
const Op = sequelize.Op;

// recomment
exports.createRecomment = async (req, res) => {
    Recomment.create({
        comment_id : req.body.commentId,
        user_id : req.body.userId,
        content : req.body.content,
        adopted_status : 0,
        deleted_status: 0,
    }).then(result => {
        if(result)
			res.json(result);
		else 
			res.json({"result":0})
    });
	Comment.findOne({
		where: {id: req.body.commentId}
	}).then(result => {
		Post.increment({
			comments_count: 1
		},{
			where: {id: result.post_id}
		})
	});
	User.increment({
		comments_count: 1
	},{
		where: {id: req.body.userId}
	});
}

exports.getRecomments = async (req, res) => {
	Recomment.findAll({
		include:[
			{
				model:	User,
				attributes: ['nickname','named_type']
			}
		],
		where: {
			[Op.and]:[
				{comment_id: req.query.commentId},
				{deleted_status: 0}
			]
		}
	}).then(result => {
		res.json(result)
	});
}

// recomment/<id>
exports.getRecomment = async (req, res) => {
    Recomment.findOne({
		include:[
			{
				model: User,
				attributes: ['nickname', 'named_type']
			}
		],
        where:{
			[Op.and]:[
				{id: req.params.recommentId},
				{deleted_status: 0}
			]
		}
    }).then(result => {
        res.json(result)
    })
}

exports.updateRecomment = async (req, res) => {
    Recomment.update({
        content : req.body.content
    },{
        where: { id: req.params.recommentId }
    }).then(result => {
		if(result)
			res.json(result);
		else
			res.json({"result":0})
    });
}

exports.deleteRecomment = async (req, res) => {
    Recomment.update({
        deleted_status : 1
    },{
        where: { id: req.params.recommentId }
    })
	Recomment.findOne({
		where: {id: req.params.recommentId}
	}).then(result => {
		User.increment({
			comments_count: -1
		},{
			where: {id: result.user_id}
		});
		Comment.findOne({
			where: {id: result.comment_id}
		}).then(result => {
			Post.increment({
				comments_count: -1
			},{
				where: {id: result.post_id}
			}).then(result => {
				if(result)
					res.json(result)
				else
					res.json({"result":0})
				});
			});
		});
}


