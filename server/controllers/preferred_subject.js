const { Preferred_subject } = require('../models');
const { Classification } = require('../models');
const sequelize = require('sequelize');
const Op =sequelize.Op;

exports.createPreferred_subject = async (req, res) => {
	Preferred_subject.create({
		user_id: req.body.userId,
		classification_id: req.body.classificationId
	}).then(result => {
		if(result)
			res.json(result)
		else
			res.json({"result": 0});
	});
}

exports.getPreferred_subjects = async (req, res) => {
	Preferred_subject.findAll({
		include:[
			{
				model: Classification,
				attributes: ['과목명','분반']
			}
		],
		where: {user_id: req.query.userId}
	}).then(result => {
		res.json(result);
	});
}

exports.deletePreferred_subject = async(req, res) => {
	Preferred_subject.destroy({
		where: {id: req.params.preferred_subjectId}
	}).then(result => {
		res.json(result);
	});
}
