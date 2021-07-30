// posts
const { Post } = require('../models');
exports.createPost = async (req, res) => {
    console.log(Post);
    // todo : get title and content with body 
    Post.create({
        classification_id : req.body.classification_id,  // 과목 정보 FK
        user_id : req.body.user_id,                     // 유저 id
        title : req.body.title,                        // 제목
        content : req.body.content,	                   // 내용
	    adopted_status: 0,                             // 채택 여부
    }).then(result => {
        res.json(result)
    });
}
// TODO: exports.getPosts

// posts/<id>
exports.getPost = async (req, res) => {
    Post.findOne({
        where: { id: req.params.postId }
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
        res.json(result);
    });
}

exports.deletePost = async (req, res) => {
    // get delete status with body
    Post.update({
	deleted_status : 1 
    },{
        where: { id: req.params.postId }

    }).then(result => {
        res.json(result);
    });
}
