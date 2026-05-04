const supabase = require('../config/supabase');

const criar = async (req, res) => {
  const { id_operador, id_maquina, id_turno } = req.body;

  if (!id_operador || !id_maquina) {
    return res.status(400).json({ error: 'id_operador e id_maquina são obrigatórios' });
  }

  const { data, error } = await supabase
    .from('checklist')
    .insert([{ id_operador, id_maquina, id_turno }])
    .select();

  if (error) return res.status(500).json({ error: error.message });
  return res.status(201).json(data[0]);
};

const salvarRespostas = async (req, res) => {
  const { id_checklist } = req.params;
  const { respostas } = req.body;

  if (!respostas || !Array.isArray(respostas)) {
    return res.status(400).json({ error: 'respostas deve ser um array' });
  }

  const registros = respostas.map(r => ({
    id_checklist: parseInt(id_checklist),
    id_item: r.id_item,
    id_status: r.id_status,
    observacao: r.observacao || null
  }));

  const { data, error } = await supabase
    .from('resposta_checklist')
    .insert(registros)
    .select();

  if (error) return res.status(500).json({ error: error.message });
  return res.status(201).json(data);
};

const historico = async (req, res) => {
  const { operador_id, maquina_id } = req.query;

  let query = supabase
    .from('checklist')
    .select('*, operador(nome), maquina(nome_maquina)')
    .order('data', { ascending: false });

  if (operador_id) query = query.eq('id_operador', operador_id);
  if (maquina_id) query = query.eq('id_maquina', maquina_id);

  const { data, error } = await query;
  if (error) return res.status(500).json({ error: error.message });
  return res.json(data);
};

const detalhe = async (req, res) => {
  const { id } = req.params;

  const { data, error } = await supabase
    .from('checklist')
    .select('*, operador(nome), maquina(nome_maquina), resposta_checklist(*, item_checklist(descricao, categoria), status_inspecao(descricao))')
    .eq('id_checklist', id)
    .single();

  if (error) return res.status(500).json({ error: error.message });
  return res.json(data);
};

module.exports = { criar, salvarRespostas, historico, detalhe };