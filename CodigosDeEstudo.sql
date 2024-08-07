/*vc tem duas tabelas uma chamada Clientes (tem id_cliente/nome) e a outra pedidos(tem id_cliente/nome) 
e eu quero como volta o nome da pessoa que pediu tal produto tipo

saia dessa maneira:

nome  |   produto
------------------
Ana   |  Tela
Carlos|  PC
José  |  mouse
*/
select nome,produto
from clientes cl
inner join pedidos on clientes.id_cliente = pedidos.id_cliente;

/*  Eu quero o nome e produto do cara que fez o Pedido 101*/
select nome,produto
from clientes cl
inner join pedidos on clientes.id_cliente = pedidos.id_cliente 
where id_pedido = 101;



/*Exemplo de um JOIN mais longo*/
SELECT pt.nome_tipo AS tipo_produto, 
	   el.estoque AS disponibilidade_estoque, 
	   dt.nome_produto, 
	   rp.descricao_recurso AS recurso, 
     sa.tamanho        
FROM  DETALHES_PRODUTO dt
JOIN ESTOQUE_LOJA el ON dt.id_produto = el.id_produto 
JOIN TIPOS_PRODUTO pt ON dt.id_tipo = pt.id_tipo
JOIN RECURSOS_PRODUTO rp ON dt.id_produto = rp.id_produto
JOIN  DISPONIBILIDADE_TAMANHO sa ON dt.id_produto = sa.id_produto
WHERE dt.id_tipo = 1  AND el.id_loja = 41  AND sa.id_tamanho = 2;  
