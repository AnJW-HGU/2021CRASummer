const { Router } = require('express');
const router = Router();
const userController = require('../controllers/user');


// nickname
router.post('/:userId/nickname', userController.createNickname); // request : { nickName: hyunseo} , receive : req.body === hyunseo
router.get('/:userId/nickname', userController.getNickname);
router.put('/:userId/nickname', userController.updateNickname); // request : { nickName: hyunseo} , receive : req.body === hyunseo
router.delete('/:userId/nickname/', userController.deleteNickname);

// points
// router.post(); // throw error
router.get('/:userId/points', userController.getPoint);
router.put('/:userId/points/:points_up', userController.updatePoint);
// router.delete(); // throw error

/************this is for test************/
router.post('/', userController.createUser);
/************test it fisrt************/

module.exports = router;

// 중복확인 api

// query
// params 
// body