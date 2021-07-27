const { Router } = require('express');
const router = Router();
const userController = require('../controllers/user');


// nickname
router.post('users?id=author_id/nickname/:nickname', userController.createNickname);
router.get('users?id=author_id/nickname/', userController.getNickname);
router.put('users?id=author_id/nickname/', userController.updateNickname);
router.delete('users?id=author_id/nickname/', userController.deleteNickname);

// // in post
// router.post(); // throw 405 error
// router.get('users/in_post/:author_id', userController.getInPost);
// router.put(); //throw error
// router.delete(); //throw error

// points
router.post(); // throw error
router.get('users?id=author_id/points', userController.getPoint);
router.put('users?id=author_id/points/:points_up', userController.updatePoint);
router.delete(); // throw error

/************this is for test************/
router.post('/users/:nickname', userController.createUser);
/************test it fisrt************/


module.exports = router;

// 중복확인 api

// query
// params 
// body