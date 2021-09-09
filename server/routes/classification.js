const { Router } = require('express');
const router = Router();
const classController = require('../controllers/classification');

router.get('/search', classController.searchClassifications);

module.exports = router;
