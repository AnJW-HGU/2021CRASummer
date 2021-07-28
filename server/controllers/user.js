const User = require('../models/user');

// nickname
exports.createNickname = async (req, res) => {
    User.findAll({
        where: { id: req.params.userId }
    }).then(result => {
        User.create({
            nickname: req.body.nickname
        })
    });
} // incomplete

exports.getNickname = async (req, res) => {
    User.findAll({
        where: { id: req.params.userId }
    }).then(result => {
        res.json(result)
    })
} // incomplete

exports.updateNickname = async (req, res) => {
    // todo : get nickname with body and insert into db
}

exports.deleteNickname = async (req, res) => {

}

// points
exports.getPoint = async (req, res) => {

}

exports.updatePoint = async (req, res) => {

}

/************this is for test************/
exports.createUser = async (req, res) => {
    var user = User.create({
        nickname: req.body.nickname
    })
    console.log(user.nickname);
}
/************this is for test************/
