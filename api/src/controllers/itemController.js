const supabase = require('../config/supabase');

const listar = async (req, res) => {
  const { data, error } = await supabase
    .from('item_checklist')
    .select('*')
    .order('id_categoria');

  if (error) return res.status(500).json({ error: error.message });
  return res.json(data);
};

module.exports = { listar };