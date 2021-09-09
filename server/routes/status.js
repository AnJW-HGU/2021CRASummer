const { Router } = require('express');
const router = Router();
const statusController = require('../controllers/status');

//router.get('/', statusController.getStatus);

//report
router.post('/report', statusController.createReport);
router.delete('/report/:reportId', statusController.deleteReport);

//recommand
router.post('/recommend', statusController.createRecommend);
router.delete('/recommend/:recommendId', statusController.deleteRecommend);

//adopt
router.put('/adopt', statusController.updateAdopt);
router.delete('/adopt', statusController.deleteAdopt);

module.exports = router;

