const { Notification } = require('../models');
const { Comment } = require('../models');
const { Post } = require('../models');
const sequelize = require('sequelize');
const Op = sequelize.Op;

exports.createNotification = async (req, res) => {
	var model = Comment;
	var loop = 1;
	var model_id = req.body.commentId
	if(req.body.body === 'recomment'){
		loop = 2;
	}
	for(var i = 0; i < 2; i++){
		model.findOne({
			where:{id: model_id}
		}).then(result => {
			Notification.create({
				kind: req.body.kind,
				read_status: 0,
				user_id: result.user_id,
				post_id: req.body.postId
			})
		});
		model = Post;
		model_id = req.body.postId
	}
	res.json({"result":1});
}

exports.getNotifications = async (req, res) => {
	Notification.destroy({
		 where: {
			[Op.and]: [
				{user_id: req.query.userId},
				{
					read_date: {
						[Op.lte] : (new Date() -  30 * 24 * 60 * 60 * 1000   )
					}
				}
			]
		}
	});
	Notification.findAll({
		include: [
			{
				model: Post,
				attributes: ['title']
			}
		],
		where: {user_id: req.query.userId},
		order: ['read_status']
		}).then(result => {
			res.json(result);
		});
}

exports.readNotification = async (req, res) => {
	Notification.update({
		read_status: 1
	},{
		where: {id: req.params.notificationId
	}
	}).then(result => {
		res.json(result);
	});
}
