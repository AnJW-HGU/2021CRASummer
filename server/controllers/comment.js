const { Comment } = require('../models/index');
const { User } = require('../models/index');
const { Post } = require('../models/index');
const sequelize = require('sequelize');
const Op = sequelize.Op;

// comment
exports.createComment = async (req, res) => {
    Comment.create({
        post_id : req.body.postId,
        user_id : req.body.userId,
        content : req.body.content,
        adopted_status : 0,
        deleted_status: 0,
    }).then(result => {
        if(result)
			res.json(result)
		else
			res.json({"result":0})
    })
	User.increment({
		comments_count: 1
	},{
		where: {id: req.body.userId}
	})
	Post.increment({
		comments_count: 1
	},{
		where: {id: req.body.postId}
	});
}

// comment/<id>
exports.getComment = async (req, res) => {
    Comment.findOne({
        where: { id: req.params.commentId }
    }).then(result => {
        console.log(result.dataValues.content);
        res.json(result.dataValues.content)
    })
}

exports.updateComment = async (req, res) => {
    Comment.update({
        content : req.body.content
    },{
        where: { id: req.params.commentId }
    }).then(result => {
        res.json(result);
    });
}

exports.deleteComment = async (req, res) => {
    Comment.update({
        deleted_status : 1
    },{
        where: { id: req.params.commentId }
    }).then(result => {
        res.json(result);
    });
}
