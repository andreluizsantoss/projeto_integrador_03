const supabase = require('../config/supabase');

const listar = async (req, res) => {
  const { data, error } = await supabase
    .from('maquina')
    .select('*');

  if (error) return res.status(500).json({ error: error.message });
  return res.json(data);
};

const cadastrar = async (req, res) => {
  const { nome_maquina, tipo, ano_fabricacao, id_empresa } = req.body;

  if (!nome_maquina) {
    return res.status(400).json({ error: 'nome_maquina é obrigatório' });
  }

  const { data, error } = await supabase
    .from('maquina')
    .insert([{ nome_maquina, tipo, ano_fabricacao, id_empresa }])
    .select();

  if (error) return res.status(500).json({ error: error.message });
  return res.status(201).json(data[0]);
};

module.exports = { listar, cadastrar };