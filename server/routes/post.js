const { Router } = require('express');
const router = Router();
const postController = require('../controllers/post');

// posts
router.post('/', postController.createPost); // get title and content with body
router.get('/',postController.getPosts);
router.get('/preferred', postController.getPreferredPosts);
router.get('/search',postController.searchPosts);
//router.get('/:keyword', postController.getPosts);
//router.put();
//router.delete();

// posts/<id>
// router.post(); // throw error
router.get('/:postId', postController.getPost);
router.put('/:postId', postController.updatePost);
router.delete('/:postId', postController.deletePost); // get delete status with body

module.exports = router;
