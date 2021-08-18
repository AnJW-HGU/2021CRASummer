const { Router } = require('express');
const router = Router();
const p_sController = require('../controllers/preferred_subject');

router.post('/', p_sController.createPreferred_subject);
router.get('/', p_sController.getPreferred_subjects);
router.delete('/:preferred_subjectId', p_sController.deletePreferred_subject);

module.exports = router;
