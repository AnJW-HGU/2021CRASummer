const { Photo } = require('../models');
const path = require('path');
const multer = require('multer');
var { v4 : uuidv4 } = require('uuid');

// set storage address and filename
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.join(__dirname + '/../src/images'));
    },
    filename: function (req, file, cb) {
        cb(null, uuidv4() + '-' + file.originalname);
   }
});

// Limit file size and type
const fileFilter = function (req,file,cb) {
    let typeArray = file.mimetype.split('/');
    let fileType = typeArray[1];
    if (fileType == 'jpg' || fileType == 'jpeg' || fileType == 'png' || fileType == 'gif') {
        cb(null, true);
    } else {
        req.fileValidationError = "jpg, jpeg, png, gif 파일만 업로드 가능합니다."
    }
}

// type of upload files - array
exports.uploadFile = multer({
    storage: storage,
    fileFilter: fileFilter,
    limits: {
        fileSize: 5 * 1024 * 1024
    }
}).array('photos');

// set id type
var which_id;
const setIdType = async (req) => {
    if (req.body.type == 'post') {
		which_id = 'post_id';
	} else if (req.body.type == 'comment') {
		which_id = 'comment_id';
    } else if (req.body.type == 'inquiry') {
		which_id = 'recomment_id';
	} else {
        console.log("no match type");
    }
}

// POST /photo
exports.createPhoto = async (req, res, next) => {
    var fs = require('fs');
    var status;
    setIdType(req);
    
    console.log("new photo is creating");
    
    for (var i = 0; i < req.files.length; i++) {
        console.log(req.files[i]);
        Photo.create({
            [which_id] : req.body.id,                               // post 정보 FK
            user_id : req.body.user_id,                             // 유저 id FK
            // type: 'png'
            original_file_name : req.files[i].originalname,			// 원본 파일 이름
            saved_file_name : req.files[i].filename,				// 저장된 파일 이름
            saved_path: __dirname + '/../src/images/',              // image data
            deleted_status: 0,                                      // 삭제 여부 
        }).then(result => {
            if(result)
                res.json(result)
            else
                res.json({"result" : 0})
        })
    }
}

// TODO : implement the element below
// GET /photo
exports.getPhotos = async (req, res) => {
    var fs = require('fs');
    var status;
    setIdType(req);

    Photo.findAll({
        where: {
            [which_id]:req.body.id
        }
    }).then(result => {
        console.log(result.body.saved_file_name);
        var photoData = fs.readFileSync(__dirname + '/../src/images/' + result.body.saved_file_name);
        
        if (photoData)
            res.json(result)
        else
            res.json({"result" : 0})
    })
}

// DELETE /photo
exports.deletePhotos = async (req, res) => {
    res.json({message: "DELETE all tea"});
}

// // photo/<id>
// exports.getPhoto = async (req, res) => {
    
// }

// exports.updatePhoto = async (req, res) => {
    
// }

// exports.deletePhoto = async (req, res) => {
    
// }
