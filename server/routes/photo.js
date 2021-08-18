const { Router } = require('express');
const router = Router();
const photoController = require('../controllers/photo');

// photos
router.post('/', photoController.uploadFile, function(req, res){
	console.log("file read");
	res.json({status: "OK"});
	console.log(req.file);
	//photoController.createPhoto
});
router.get('/', photoController.getPhotos);
router.put('/', photoController.updatePhotos);
router.delete('/', photoController.deletePhotos);

// photos/<id>
// router.post(); // throw error
router.get('/:photoId',photoController.getPhoto); 
router.put('/:photoId',photoController.updatePhoto);
router.delete('/:photoId',photoController.deletePhoto);

module.exports = router;
