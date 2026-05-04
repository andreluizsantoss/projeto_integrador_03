const swaggerJsdoc = require('swagger-jsdoc');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'API Checklist Divina Florestal',
      version: '1.0.0',
      description: 'API REST para registro digital de checklists de máquinas agrícolas',
    },
    servers: [
      {
        url: 'https://checklist-api-p9jj.onrender.com',
        description: 'Servidor de produção',
      },
      {
        url: 'http://localhost:3000',
        description: 'Servidor local',
      },
    ],
    components: {
      schemas: {
        Operador: {
          type: 'object',
          properties: {
            id_operador: { type: 'integer', example: 1 },
            nome: { type: 'string', example: 'João Silva' },
            idade: { type: 'integer', example: 45 },
            id_empresa: { type: 'integer', example: 1 },
          },
        },
        Maquina: {
          type: 'object',
          properties: {
            id_maquina: { type: 'integer', example: 1 },
            nome_maquina: { type: 'string', example: 'Trator John Deere' },
            tipo: { type: 'string', example: 'Trator' },
            ano_fabricacao: { type: 'integer', example: 2020 },
            id_empresa: { type: 'integer', example: 1 },
          },
        },
        Checklist: {
          type: 'object',
          properties: {
            id_checklist: { type: 'integer', example: 1 },
            data: { type: 'string', example: '2026-04-28T10:00:00Z' },
            id_operador: { type: 'integer', example: 1 },
            id_maquina: { type: 'integer', example: 1 },
            id_turno: { type: 'integer', example: 1 },
          },
        },
        Resposta: {
          type: 'object',
          properties: {
            id_item: { type: 'integer', example: 1 },
            id_status: { type: 'integer', example: 1, description: '1=Conforme, 2=Não Conforme, 3=Precisa Manutenção' },
            observacao: { type: 'string', example: 'Verificado ok' },
          },
        },
        StatusInspecao: {
          type: 'object',
          properties: {
            id_status: { type: 'integer' },
            descricao: { type: 'string', example: 'Conforme' },
          },
        },
      },
    },
    paths: {
      '/auth/login': {
        post: {
          summary: 'Login do operador',
          tags: ['Autenticação'],
          requestBody: {
            required: true,
            content: {
              'application/json': {
                schema: {
                  type: 'object',
                  properties: {
                    id_operador: { type: 'integer', example: 1 },
                    pin: { type: 'integer', example: 1234 },
                  },
                },
              },
            },
          },
          responses: {
            200: { description: 'Login realizado com sucesso' },
            400: { description: 'id_operador e pin são obrigatórios' },
            401: { description: 'Operador ou PIN inválido' },
          },
        },
      },
      '/operadores': {
        get: {
          summary: 'Lista todos os operadores',
          tags: ['Operadores'],
          responses: {
            200: {
              description: 'Lista de operadores',
              content: {
                'application/json': {
                  schema: { type: 'array', items: { '$ref': '#/components/schemas/Operador' } },
                },
              },
            },
          },
        },
        post: {
          summary: 'Cadastra novo operador',
          tags: ['Operadores'],
          requestBody: {
            required: true,
            content: {
              'application/json': {
                schema: {
                  type: 'object',
                  properties: {
                    nome: { type: 'string', example: 'João Silva' },
                    pin: { type: 'integer', example: 1234 },
                    idade: { type: 'integer', example: 45 },
                    id_empresa: { type: 'integer', example: 1 },
                  },
                },
              },
            },
          },
          responses: {
            201: { description: 'Operador cadastrado com sucesso' },
            400: { description: 'nome e pin são obrigatórios' },
          },
        },
      },
      '/maquinas': {
        get: {
          summary: 'Lista todas as máquinas',
          tags: ['Máquinas'],
          responses: {
            200: {
              description: 'Lista de máquinas',
              content: {
                'application/json': {
                  schema: { type: 'array', items: { '$ref': '#/components/schemas/Maquina' } },
                },
              },
            },
          },
        },
        post: {
          summary: 'Cadastra nova máquina',
          tags: ['Máquinas'],
          requestBody: {
            required: true,
            content: {
              'application/json': {
                schema: {
                  type: 'object',
                  properties: {
                    nome_maquina: { type: 'string', example: 'Trator John Deere' },
                    tipo: { type: 'string', example: 'Trator' },
                    ano_fabricacao: { type: 'integer', example: 2020 },
                    id_empresa: { type: 'integer', example: 1 },
                  },
                },
              },
            },
          },
          responses: {
            201: { description: 'Máquina cadastrada com sucesso' },
            400: { description: 'nome_maquina é obrigatório' },
          },
        },
      },
      '/itens': {
        get: {
          summary: 'Lista todos os itens do checklist por categoria',
          tags: ['Itens'],
          responses: {
            200: { description: 'Lista de itens do checklist' },
          },
        },
      },
      '/checklists': {
        post: {
          summary: 'Cria novo checklist',
          tags: ['Checklists'],
          requestBody: {
            required: true,
            content: {
              'application/json': {
                schema: {
                  type: 'object',
                  properties: {
                    id_operador: { type: 'integer', example: 1 },
                    id_maquina: { type: 'integer', example: 1 },
                    id_turno: { type: 'integer', example: 1 },
                  },
                },
              },
            },
          },
          responses: {
            201: { description: 'Checklist criado com sucesso' },
            400: { description: 'id_operador e id_maquina são obrigatórios' },
          },
        },
        get: {
          summary: 'Histórico de checklists',
          tags: ['Checklists'],
          parameters: [
            { name: 'operador_id', in: 'query', schema: { type: 'integer' }, example: 1 },
            { name: 'maquina_id', in: 'query', schema: { type: 'integer' }, example: 1 },
          ],
          responses: {
            200: { description: 'Lista de checklists' },
          },
        },
      },
      '/checklists/{id_checklist}/respostas': {
        post: {
          summary: 'Salva respostas do checklist',
          tags: ['Checklists'],
          parameters: [
            { name: 'id_checklist', in: 'path', required: true, schema: { type: 'integer' }, example: 1 },
          ],
          requestBody: {
            required: true,
            content: {
              'application/json': {
                schema: {
                  type: 'object',
                  properties: {
                    respostas: {
                      type: 'array',
                      items: { '$ref': '#/components/schemas/Resposta' },
                      example: [
                        { id_item: 1, id_status: 1, observacao: '' },
                        { id_item: 2, id_status: 3, observacao: 'Verificar buzina' },
                      ],
                    },
                  },
                },
              },
            },
          },
          responses: {
            201: { description: 'Respostas salvas com sucesso' },
            400: { description: 'respostas deve ser um array' },
          },
        },
      },
      '/checklists/{id}': {
        get: {
          summary: 'Detalhe de um checklist',
          tags: ['Checklists'],
          parameters: [
            { name: 'id', in: 'path', required: true, schema: { type: 'integer' }, example: 1 },
          ],
          responses: {
            200: { description: 'Detalhe do checklist com respostas' },
            500: { description: 'Erro ao buscar checklist' },
          },
        },
      },
    },
  },
  apis: [],
};

const swaggerSpec = swaggerJsdoc(options);
module.exports = swaggerSpec;