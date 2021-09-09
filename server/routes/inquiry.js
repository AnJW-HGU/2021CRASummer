const { Router } = require('express');
const router = Router();
const inquiryController = require('../controllers/inquiry');

router.post('/', inquiryController.createInquiry);
router.get('/', inquiryController.getInquiries);


router.get('/:inquiryId', inquiryController.getInquiry);
router.put('/:inquiryId', inquiryController.updateInquiry);
router.patch('/:inquiryId', inquiryController.completeInquiry);
router.delete('/:inquiryId', inquiryController.deleteInquiry);

module.exports = router;
