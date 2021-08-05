// posts
const { Post } = require('../models');
const { User } = require('../models');
const sequelize = require("sequelize");
const Op = sequelize.Op;

exports.createPost = async (req, res) => {
    Post.create({
        classification_id : req.body.classificationId,  // 과목 정보 FK
        user_id : req.body.userId,                     // 유저 id
        title : req.body.title,                        // 제목
        content : req.body.content,                        // 내용
        adopted_status: 0,                             // 채택 여부	   
		deleted_status: 0
    }).then(result => {
	    if(result)
	        res.json(result)
	    else
			res.json({"result" : 0})
    });
    User.increment({
	    posts_count: 1
    },{
	    where: {id: req.body.userId}
    });
}

exports.getPosts = async (req, res) => {
	Post.findAll({
		where: {
		[Op.and]:[
		{
			[Op.or]:[
				{title: {
						[Op.like]: "%"+req.query.searchKeyword+"%"}
				},{	content: {
						[Op.like]: "%"+req.query.searchKeyword+"%"}
	}]},{
			[Op.or]:[
				{deleted_status: 0},
				{deleted_status: null}
			]}]}
	}).then(result => {
		res.json(result)
	});
}

// posts/<id>
exports.getPost = async (req, res) => {
    Post.findOne({
	include: [
		{
	        model: User,
		    attributes: ['nickname', 'named_type']
		}
	],
        where: { 
			[Op.and]: [{
				[Op.or]: [
					{deleted_status: 0},
					{deleted_status: null}
				]},{id: req.params.postId }
			]}
    }).then(result => {
		res.json(result)
    });
}

exports.updatePost = async (req, res) => {
    // get title and content with body
    Post.update({
        title : req.body.title,
        content : req.body.content
    },{
        where: { id: req.params.postId }
    }).then(result => {
	    if(result)
	        res.json(result)
	    else
		res.json({"result" : 0})
    });
}

exports.deletePost = async (req, res) => {
    // get delete status with body
    Post.update({
        deleted_status : 1
    },{
        where: { id: req.params.postId }

    });
	Post.findOne({
		where: { id: req.params.postId }
	}).then(result => {
		User.increment({
			posts_count: -1
		},{
			where: {id: result.user_id}
		});
	}).then(result => {
		if(result)
			res.json(result)
		else
			res.json({"result":0})
	});
}


