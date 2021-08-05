const { Photo, Post, Comment, Inquiry } = require('../models');

// var model;

// photo
exports.createPhoto = async (req, res) => {
    var fs = require('fs');

    if (req.body.type == 'post') {
		which_id = 'post_id';
	} else if (req.body.type == 'comment') {
		which_id = 'comment_id';
    } else if (req.body.type == 'inquiry') {
		which_id = 'recomment_id';
	} else {
        // make error
    }

    var photoData = fs.readFileSync(__dirname + '/../static/assets/images/jsa-header.png');
    Photo.create({
        [which_id] : req.body.id,                               // post 정보 FK
        user_id : req.body.userId,                              // 유저 id FK
        // type: 'png'
        original_file_name : 'jsa-header.png',					// 원본 파일 이름
        saved_file_name : 'new-jsa-header.png',					// 저장된 파일 이름
        data: photoData,                                        // image data
        saved_path: __dirname + '/../static/assets/images/',    // image data
        deleted_status: 0,                                      // 삭제 여부 
    }).then(photo => {
        try{
			var path = Photo.saved_path + Photo.saved_file_name
            fs.writeFileSync(path, photo.data);
            res.json(photo);
        }catch(e){
            console.log(e);
            res.json({"photo" : 0});
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
