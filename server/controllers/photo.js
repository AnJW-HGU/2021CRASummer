const { Photo, Post, Comment, Inquiry } = require('../models');

var model;

// photo
exports.createPhoto = async (req, res) => {
    var fs = require('fs');

    if (req.body.type == 'post') {
		model = Post;
		which_id = 'post_id';
	} else if (req.body.type == 'comment') {
		model = Comment;
		which_id = 'comment_id';
    } else if (req.body.type == 'inquiry') {
		model = Recomment;
		which_id = 'recomment_id';
	} else {
        // make error
    }

    var imageData = fs.readFileSync(__dirname + '/../static/assets/images/jsa-header.png');
    Image.create({
        [which_id] : req.body.id,                   // post 정보 FK
        user_id : req.body.userId,                  // 유저 id FK
        // type: 'png'
        original_file_name : req.body.title,        // 원본 파일 이름
        saved_file_name : req.body.content,         // 저장된 파일 이름
        data: imageData,                            // image data
        deleted_status: 0,                             // 삭제 여부 
    }).then(image => {
        try{
            fs.writeFileSync(__dirname + '/../static/assets/images/jsa-header.png', image.data);				
        }catch(e){
            console.log(e);
        }
    })
}

exports.getPhotos = async (req, res) => {
    
}

exports.updatePhotos = async (req, res) => {
    
}

exports.deletePhotos = async (req, res) => {
    
}

// photo/<id>
exports.getPhoto = async (req, res) => {
    
}

exports.updatePhoto = async (req, res) => {
    
}

exports.deletePhoto = async (req, res) => {
    
}
