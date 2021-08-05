const { Router } = require('express');
const router = Router();
const recommentController = require('../controllers/recomment');

// recomment
router.post('/', recommentController.createRecomment); // get userid and content of the comment with body
router.get('/', recommentController.getRecomments);
// router.put('/', recommentController.updateRecomments);
// router.delete('/', recommentController.deleteRecomments);

// reomment/<id>
// router.post(); // trow error
router.get('/:recommentId', recommentController.getRecomment);
router.put('/:recommentId', recommentController.updateRecomment); // get content of recomment with body
router.delete('/:recommentId', recommentController.deleteRecomment); // get deleted statud with body

module.exports = router;
