const User = require('../models/user');

// request should have id(user PK) and nickname
// create Nickname

/************this is for test************/
exports.createUser = async (req, res) => {
    var user = User.create({
        nickname: req.params.nickname
    })
    console.log(user.nickname);
}
/************this is for test************/

// nickname
exports.createNickname = async (req, res) => {
    User.findAll({
        where: { id: req.params.author_id }
    }).then(result => {
        User.create({
            nickname: req.params.nickname
        })
    });
} 

exports.getNickname = async (req, res) => {
    User.findAll({
        where: { id: req.params.author_id }
    }).then(result => {
        res.json(result)
    })
}

