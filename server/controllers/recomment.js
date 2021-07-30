const { Recomment } = require('../models/index');

// recomment
exports.createRecomment = async (req, res) => {
    Recomment.create({
        comment_id : req.body.commentId,
        user_id : req.body.userId,
        content : req.body.content,
        adopted_status : 0,
        deleted_status: 0,
    }).then(result => {
        res.json(result);
    });
}

// exports.getRecomments = async (req, res) => {
    
// }

// exports.updateRecomments = async (req, res) => {

// }

// exports.deleteRecomments = async (req, res) => {

// } 

// recomment/<id>
exports.getRecomment = async (req, res) => {
    Recomment.findOne({
        where: { id: req.params.recommentId }
    }).then(result => {
        console.log(result.dataValues.content);
        res.json(result.dataValues.content)
    })
}

exports.updateRecomment = async (req, res) => {
    Recomment.update({
        content : req.body.content
    },{
        where: { id: req.params.recommentId }
    }).then(result => {
        res.json(result);
    });
}

exports.deleteRecomment = async (req, res) => {
    Recomment.update({
        deleted_status : 1
    },{
        where: { id: req.params.recommentId }
    }).then(result => {
        res.json(result);
    });
}


