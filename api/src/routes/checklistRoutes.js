const express = require('express');
const router = express.Router();
const { criar, salvarRespostas, historico, detalhe } = require('../controllers/checklistController');

router.post('/', criar);
router.post('/:id_checklist/respostas', salvarRespostas);
router.get('/', historico);
router.get('/:id', detalhe);

module.exports = router;