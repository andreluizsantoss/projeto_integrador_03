const supabase = require('../config/supabase');

const login = async (req, res) => {
  const { id_operador, pin } = req.body;

  if (!id_operador || !pin) {
    return res.status(400).json({ error: 'id_operador e pin são obrigatórios' });
  }

  const { data, error } = await supabase
    .from('operador')
    .select('*')
    .eq('id_operador', id_operador)
    .eq('pin', pin)
    .single();

  if (error || !data) {
    return res.status(401).json({ error: 'Operador ou PIN inválido' });
  }

  return res.json({ message: 'Login realizado com sucesso', operador: data });
};

module.exports = { login };