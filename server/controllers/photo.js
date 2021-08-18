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
