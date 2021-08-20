const { Router } = require('express');
const router = Router();
const notiController = require('../controllers/notification');

router.post('/', notiController.createNotification);
router.get('/', notiController.getNotifications);

router.put('/:notificationId', notiController.readNotification);

module.exports = router;
