// Status
const { Post } = require('../models');
const { Comment } = require('../models');
const { Recomment } = require('../models');
const { User } = require('../models');
const { Report } = require('../models');
const { Recommend } = require('../models');
const sequelize = require("sequelize");
const Op = sequelize.Op;

var model;
var which_id;

exports.createReport = async (req, res) => {
	switch(req.body.type){
		case 'post':
			model = Post;
			which_id = 'post_id';
			break;
		case 'comment':
			model = Comment;
			which_id = 'comment_id';
			break;
		case 'recomment':
			model = Recomment;
			which_id = 'recomment_id';
			break;
	}
	Report.findOrCreate({
		where:{
			[Op.and]:[{
				[which_id]: req.body.id
				},{
				user_id: req.body.userId
				},{
				deleted_status: 0
				}]},
		defaults:{	
			content: req.body.content,
			completed_status: 0,
			deleted_status: 0,
			user_id: req.body.userId,
			[which_id]:req.body.id
	}}).then(result => {
		if(result[1]){
			model.increment({
				reports_count: 1
			},{
				where: {id: req.body.id}
			});
				model.findOne({
					where: {id: req.body.id}
				}).then(result => {
					User.increment({
						reports_count: 1
					},{
						where: {id: result.user_id}
					});
				});
				res.json(result);
		} else {
			res.json(result[1]);
		}
	});
}

exports.deleteReport = async (req, res) => {
	switch(req.body.type){
		case 'post':
			model = Post;
			which_id = 'post_id';
			break;
		case 'comment':
			model = Comment;
			which_id = 'comment_id';
			break;
		case 'recomment':
			model = Recomment;
			which_id = 'recomment_id';
			break;
	}
	Report.update({
		deleted_status : 1
	},{
		where: {id: req.params.reportId}
	});
	model.findOne({
		where: {id:req.body.id}
	}).then(result => {
		User.increment({
			reports_count: -1
	},{
		where: {id: result.user_id}
	});
	}).then(result => {
		if(result)
			res.json(result);
		else
			res.json({"result":0});
	});
}

exports.createRecommend = async (req, res) => {
	Recommend.findOrCreate({
		where:{
			[Op.and]:[{
				comment_id: req.body.id
				},{
				user_id: req.body.userId
				},{
				deleted_status: 0
		}]},
		defaults:{
			completed_status:0,
			deleted_status: 0,
			comment_id: req.body.id,
			user_id: req.body.userId
		}}).then(result => {
			if(result[1]){
				Comment.increment({
					recommends_count: 1
				},{
					where: {id: req.body.id}
				})
				res.json(result)
			} else {
				res.json(result[1])
			}
		});
	
}

exports.deleteRecommend = async (req, res) => {
	Recommend.update({
		deleted_status : 1
	},{
		where: {id: req.params.recommendId}
	}).then(result => {
		if(result)
			res.json(result);
		else
			res.json({"result":0});
	});
	Comment.increment({
		recommends_count: -1
	},{
		where: {id: req.body.id}
	});
}

exports.updateAdopt = async (req, res) => {
	Comment.update({
		adopted_status: 1
	},{
		where: {id: req.body.id}
	}).then(result => {
		res.json(result)
	});
	Comment.findOne({
		where: {id: req.body.id}
	}).then(result => {
		Post.update({
			adopted_status: 1
		},{
			where: {id: result.post_id}		
		}
	)});
}

exports.deleteAdopt = async (req, res) => {
	Comment.update({
		adopted_status: 0
	},{
		where: {id: req.body.id}
	}).then(result => {
		res.json(result)
	});
	Comment.findOne({
		where: {id: req.body.id}
	}).then(result => {
		Post.update({
			adopted_status: 0
		},{
			where: {id: result.post_id}		
		}
	)});
}
	
