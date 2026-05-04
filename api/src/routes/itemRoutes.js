const express = require('express');
const router = express.Router();
const { listar } = require('../controllers/itemController');

router.get('/', listar);

module.exports = router;