const supabase = require('../config/supabase');

const listar = async (req, res) => {
  const { data, error } = await supabase
    .from('operador')
    .select('id_operador, nome, idade, id_empresa');

  if (error) return res.status(500).json({ error: error.message });
  return res.json(data);
};

const cadastrar = async (req, res) => {
  const { nome, pin, idade, id_empresa } = req.body;

  if (!nome || !pin) {
    return res.status(400).json({ error: 'nome e pin são obrigatórios' });
  }

  const { data, error } = await supabase
    .from('operador')
    .insert([{ nome, pin, idade, id_empresa }])
    .select();

  if (error) return res.status(500).json({ error: error.message });
  return res.status(201).json(data[0]);
};

module.exports = { listar, cadastrar };