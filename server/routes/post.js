const { Router } = require('express');
const router = Router();
const postController = require('../controllers/post');

// posts
router.post('/:classId/:userId/:photoId', postController.createPost); // get title and content with body
//router.get('/:keyword', postController.getPosts);
//router.put();
//router.delete();

// posts/<id>
router.post(); // throw error
router.get('/:postId', postController.getPost);
router.put('/:postId', postController.updatePost);
router.delete('/:postId', postController.deletePost); // get delete status with body

/*
// posts/<id>/photos
router.post('/postId/photos');
router.get();
router.put();
router.delete();

// posts/<id>/photos/<id>
router.post();
router.get();
router.put();
router.delete();


// posts/<id>/comments
router.post('/:postId/comment', postController.createComment); // get userid and content of the comment with body
router.get('/:postId/comment', postController.getComments);
router.put('/:postId/comment', postController.updateComments);
router.delete('/:postId/comment', postController.deleteComments);

// posts<id>/comments/<id>
router.post(); // throw error
router.get('/:postId/comment/:commentId', postController.getComment);
router.put('/:postId/comment/:commentId', postController.updateComment); // get content of comment with body
router.delete('/:postId/comment/:commentId', postController.deleteComment); // get deleted statud with body

// posts<id>/comments/<id>/recomments
router.post('/:postId/comment/:commentId/recomment', postController.createRecomment); // get userid and content of the comment with body
router.get('/:postId/comment/:commentId/recomment', postController.getRecomments);
router.put('/:postId/comment/:commentId/recomment', postController.updateRecomments);
router.delete('/:postId/comment/:commentId/recomment', postController.deleteRecomments);

// posts<id>/comments/<id>/recomments/<id>
router.post(); // trow error
router.get('/:postId/comment/:commentId/recomment/:recommentId', postController.getRecomment);
router.put('/:postId/comment/:commentId/recomment/:recommentId', postController.updateRecomment); // get content of recomment with body
router.delete('/:postId/comment/:commentId/recomment/:recommentId', postController.deleteRecomment); // get deleted statud with body
*/