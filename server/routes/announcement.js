const { Router } = require('express');
const router = Router();
const announceController = require('../controllers/announcement');

router.post('/', announceController.createAnnounce);
router.get('/', announceController.getAnnounces);

router.get('/:announcementId', announceController.getAnnounce);
router.put('/:announcementId', announceController.updateAnnounce);
router.delete('/:announcementId', announceController.deleteAnnounce);

module.exports = router;
