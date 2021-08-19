const { Router } = require('express');
const router = Router();
const commentController = require('../controllers/comment');

// comment
router.post('/', commentController.createComment);
router.get('/', commentController.getComments);
router.get('/user', commentController.getUserComments);
// comment/<id>
router.post('/:commentId',); // throw 405 error
router.get('/:commentId', commentController.getComment);
router.put('/:commentId', commentController.updateComment);
router.delete('/:commentId', commentController.deleteComment);

module.exports = router;
