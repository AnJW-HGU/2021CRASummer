const { Comment } = require('../models/index');

// comment
exports.createComment = async (req, res) => {
    Comment.create({
        post_id : req.body.postId,
        user_id : req.body.userId,
        content : req.body.content,
        adopted_status : 0,
        deleted_status: 0,
    }).then(result => {
        res.json(result);
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
