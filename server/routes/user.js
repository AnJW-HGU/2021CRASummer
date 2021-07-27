const { Router } = require('express');
const router = Router();
const userController = require('../controllers/user');


// nickname
router.post('users/:author_id/nickname/:nickname', userController.createNickname);
router.get('users/:author_id/nickname/', userController.getNickname);
router.put('users/:author_id/nickname/', userController.updateNickname);
router.delete('users/:author_id/nickname/', userController.deleteNickname);

// // in post
// router.post(); // throw 405 error
// router.get('users/in_post/:author_id', userController.getInPost);
// router.put(); //throw error
// router.delete(); //throw error

// points
router.post(); // throw error
router.get('users/points?id=author_id', userController.getPoint);
router.put('users/points?id=author_id/:points_up', userController.updatePoint);
router.delete(); // throw error

/************this is for test************/
router.post('/users/:nickname', userController.createUser);
/************test it fisrt************/


module.exports = router;

// 중복확인 api

// query
// params 
// body