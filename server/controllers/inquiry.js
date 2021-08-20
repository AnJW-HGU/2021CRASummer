const { Inquiry } = require('../models');
const { User } = require('../models');
const sequelize = require('sequelize');
const Op = sequelize.Op;

exports.createInquiry = async (req, res) => {
	Inquiry.create({
		user_id: req.body.userId,
		post_id: req.body.postId,
		kind: req.body.kind,
		title: req.body.title,
		content: req.body.content,
		completed_status: 0,
		deleted_status: 0
	}).then(result => {
		if(result)
			res.json(result)
		else
			res.json({"result":0});
	});
}

exports.getInquiries = async (req, res) => {
	Inquiry.findAll({
		include:[
			{
				model: User,
				attributes: ['nickname']
			}
		],
		where:{
			[Op.and]: [
				{kind: req.query.kind},
				{deleted_status: 0}
			]},
		order:['completed_status']
	}).then(result => {
		res.json(result)
	});

}

exports.getInquiry = async (req, res) => {
	Inquiry.findAll({
		include:[
			{
				model: User,
				attributes: ['nickname','email', 'comments_count', 'adopts_count', 'posts_count', 'named_type', 'reports_count', 'points' ],
			}
		],
		where:{
			[Op.and]: [
				{id: req.params.inquiryId},
				{deleted_status: 0}
			]
		}
	}).then(result => {
		res.json(result);
	});
}

exports.updateInquiry = async (req, res) => {
	Inquiry.update({
		title: req.body.title,
		content: req.body.content
	},{
		where: {id: req.params.inquiryId}
	}).then(result => {
		if(result)
			res.json(result)
		else
			res.json({"result": 0});
	});
}

exports.completeInquiry = async (req, res) => {
	Inquiry.update({
		completed_status: 1
	},{
		where: {id: req.params.inquiryId}
	}).then(result => {
		if(result)
			res.json(result)
		else 
			res.json({"result": 0});
	});
}

exports.deleteInquiry = async (req, res) => {
	Inquiry.update({
		deleted_status: 1
	},{
		where: {id: req.params.inquiryId}
	}).then(result => {
		if(result)
			res.json(result)
		else
			res.json({"result": 0});
	});
}
