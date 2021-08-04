const { Router } = require('express');
const router = Router();
const userController = require('../controllers/user');

// for test
router.post('/',userController.createUser);

// nickname
router.post('/:userId/nickname', userController.createNickname); // request : { nickName: hyunseo} , receive : req.body === hyunseo
router.get('/:userId/nickname', userController.getNickname);
router.put('/:userId/nickname', userController.updateNickname); // request : { nickName: hyunseo} , receive : req.body === hyunseo
router.delete('/:userId/nickname/', userController.deleteNickname);

// points
// router.post(); // throw error
router.get('/:userId/points', userController.getPoint);
router.put('/:userId/points/', userController.updatePoint);
// router.delete(); // throw error


module.exports = router;

// ¿¿¿¿ api
