const { Announcement } = require('../models');

exports.createAnnounce = async (req, res) => {
	Announcement.create({
		user_id: req.body.userId,
		kind: req.body.kind,
		title: req.body.title,
		content: req.body.content
	}).then(result => {
		if(result)
			res.json(result)
		else
			res.json({"result": 0})
	});
}

exports.getAnnounces = async (req, res) => {
	Announcement.findAll().then(result => {
		res.json(result)
	});
}

exports.getAnnounce = async (req, res) => {
	Announcement.findOne({
		where: {id: req.params.announcementId}
	}).then(result => {
		res.json(result);
	});
}

exports.updateAnnounce = async (req, res) => {
	Announcement.update({
		title: req.body.title,
		content: req.body.content
	},{
		where: {id: req.params.announcementId}
	}).then(result => {
		if(result)
			res.json(result)
		else
			res.json({"result": 0});
	});
}

exports.deleteAnnounce = async (req, res) => {
	Announcement.destroy({
		where: {id: req.params.announcementId}
	}).then(result => {
		if(result)
			res.json(result)
		else
			res.json({"result": 0});
	});
}
