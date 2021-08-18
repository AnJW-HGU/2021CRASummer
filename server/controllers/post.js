// posts
const { Post } = require('../models');
const { User } = require('../models');
const { Classification } = require('../models');
const { Preferred_subject } = require('../models');
const sequelize = require("sequelize");
const Op = sequelize.Op;

exports.createPost = async (req, res) => {
    Post.create({
        classification_id : req.body.classificationId,  // 과목 정보 FK
        user_id : req.body.userId,                     // 유저 id
        title : req.body.title,                        // 제목
        content : req.body.content,                        // 내용
		category: req.body.category,
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
	if(req.query.category === 'all'){
		Post.findAll({
			include:[
				{
					model: Classification,
					attributes: ['과목명', '분반']
				}
			],
			where:{deleted_status: 0},
			}).then(result => {
			res.json(result);
		});
	} else {
		Post.findAll({
			include:[
				{
					model: Classification,
					attributes: ['과목명', '분반']
				}
			],
			where:{
				[Op.and]:[
					{deleted_status: 0},
					{category: req.query.category}
				]}
			}).then(result => {
			res.json(result);
		});
	}

}

exports.getPreferredPosts = async (req, res) => {
	var p_sResult = [];
	Preferred_subject.findAll({
		where: {user_id: req.query.userId}
	}).then(result => {
		for(p_s in result){
			p_sResult[p_s] = result[p_s].dataValues.classification_id;
		}
		Post.findAll({
			where: {
				[Op.and]:[
					{classification_id: p_sResult},
					{deleted_status: 0}
				]
			}
		}).then(result2 => {
			res.json(result2);
		})
	})
}
			
exports.searchPosts = async (req, res) => {
	Post.findAll({
		include:[
			{
				model: Classification,
				attributes: ['과목명','분반']
			}
		],
		where: {
		[Op.and]:[
		{
			[Op.or]:[
				{title: {
						[Op.like]: "%"+req.query.searchKeyword+"%"}
				},{	content: {
						[Op.like]: "%"+req.query.searchKeyword+"%"}
					}
			]
		},
			{deleted_status: 0},
		]}
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
			[Op.and]: [
				{deleted_status: 0},
				{id: req.params.postId}
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


