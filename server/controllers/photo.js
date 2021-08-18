const { Photo } = require('../models');
const path = require('path');
const multer = require('multer');
var { v4 : uuidv4 } = require('uuid');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.join(__dirname + '/../src/images'));
    },
    filename: function (req, file, cb) {
        cb(null, uuidv4() + '.jpg');
   }
});
exports.uploadFile = multer({ storage: storage }).single('file');

// photo/
exports.createPhoto = async (req, res, next) => {
    var fs = require('fs');
    var which_id;

    if (req.body.type == 'post') {
		which_id = 'post_id';
	} else if (req.body.type == 'comment') {
		which_id = 'comment_id';
    } else if (req.body.type == 'inquiry') {
		which_id = 'recomment_id';
	} else {
        // make error
    }
    
    console.log("new photo is creating");
    Photo.create({
        [which_id] : req.body.id,                               // post 정보 FK
        user_id : req.body.user_id,                              // 유저 id FK
        // type: 'png'
        original_file_name : req.file.originalname,			    // 원본 파일 이름
        saved_file_name : req.file.filename,					// 저장된 파일 이름
        saved_path: __dirname + '/../src/images/',              // image data
        deleted_status: 0,                                      // 삭제 여부 
    }).then(photo => {
        try{
			var path = Photo.saved_path + Photo.saved_file_name
            fs.writeFileSync(path, photo.data);
            res.json(photo);
        }catch(e){
            console.log(e);
            res.json({ "photo" : 0 });
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
