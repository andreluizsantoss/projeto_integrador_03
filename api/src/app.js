const express = require('express');
const cors = require('cors');

const authRoutes = require('./routes/authRoutes');
const operadorRoutes = require('./routes/operadorRoutes');
const maquinaRoutes = require('./routes/maquinaRoutes');
const checklistRoutes = require('./routes/checklistRoutes');
const itemRoutes = require('./routes/itemRoutes');

const app = express();
app.use(cors());
app.use(express.json());

app.use('/auth', authRoutes);
app.use('/operadores', operadorRoutes);
app.use('/maquinas', maquinaRoutes);
app.use('/checklists', checklistRoutes);
app.use('/itens', itemRoutes);

app.get('/', (req, res) => {
  res.json({ message: 'API Checklist Divina Florestal - OK' });
});

module.exports = app;