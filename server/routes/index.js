const express = require('express');
const router = express.Router();

const userRouter = require('./user');
const postRouter = require('./post');
const commentRouter = require('./comment');
const recommentRouter = require('./recomment');
const photoRouter = require('./photo');
const statusRouter = require('./status');

router.use('/user', userRouter);
router.use('/post', postRouter);
router.use('/comment', commentRouter);
router.use('/recomment', recommentRouter);
router.use('/photo', photoRouter);
router.use('/status', statusRouter);

module.exports = router;
