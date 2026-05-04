const express = require('express');
const router = express.Router();
const { listar, cadastrar } = require('../controllers/operadorController');

router.get('/', listar);
router.post('/', cadastrar);

module.exports = router;