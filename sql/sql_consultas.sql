---Consulta quantidade de vendas do Marea

SELECT COUNT(v.idvenda) AS qtd_vendas_marea
FROM vendas v
  INNER JOIN carros c ON c.idcarro = v.idcarro
WHERE c.modelo = 'Marea';

---Consulta quantidade de vendas do Uno

SELECT cl.idcliente,
       cl.nome,
       COUNT(v.idvenda) AS qtd_vendas_uno
FROM vendas v
 	INNER JOIN carros c ON c.idcarro = v.idcarro
 	INNER JOIN clientes cl ON cl.idcliente = v.idcliente
WHERE c.modelo = 'Uno'
GROUP BY cl.idcliente, cl.nome

---Consulta a quantidade de clientes que não efetuaram venda

SELECT COUNT(c.idcliente) AS qtd_nao_vendidos
FROM clientes c
WHERE NOT EXISTS (SELECT v.idcliente
                  FROM vendas v
                  WHERE v.idcliente = c.idcliente)

---Consulta os clientes que ganharam o sorteio

SELECT c.nome, ca.modelo , v.data_venda
FROM vendas v
	INNER JOIN clientes c ON c.idcliente = v.idcliente
    INNER JOIN carros ca ON ca.idcarro = v.idcarro
WHERE ca.modelo = 'Marea'
  AND c.cpf LIKE '0%'
  AND ca.data_lancamento >= '2021-01-01'
  AND ca.data_lancamento < '2022-01-01'
  AND NOT EXISTS (SELECT 1
                  FROM vendas v2
                  	INNER JOIN carros ca2 ON ca2.idcarro = v2.idcarro
                  WHERE v2.idcliente = c.idcliente
                  	AND ca2.modelo = 'Marea'
                  GROUP BY v2.idcliente
                  HAVING COUNT(*) >= 2
                  ) ---Caso tenha comprado dois carros do modelo Marea está desclassificado
ORDER BY data_venda ASC
LIMIT 15 ---Considerando apenas os 15 primeiros registros





