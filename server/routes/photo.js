const { Router } = require('express');
const router = Router();
const photoController = require('../controllers/photo');

// posts/<id>/photos
router.post('/', photoController.createPhoto);
router.get('/', photoController.getPhotos);
router.put('/', photoController.updatePhotos);
router.delete('/', photoController.deletePhotos);

// posts/<id>/photos/<id>
router.post(); // throw error
router.get('/:photoId',photoController.getPhoto); 
router.put('/:photoId',photoController.updatePhoto);
router.delete('/:photoId',photoController.deletePhoto);