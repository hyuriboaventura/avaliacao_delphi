---Remove todas as vendas que não são dos clientes sorteados

DELETE FROM vendas v
WHERE NOT EXISTS (
				  SELECT 1
                  FROM (
                        SELECT DISTINCT v2.idcliente, v2.data_venda
                        FROM vendas v2
                          INNER JOIN clientes c ON c.idcliente = v2.idcliente
                          INNER JOIN carros ca ON ca.idcarro = v2.idcarro
                        WHERE ca.modelo = 'Marea'
                          AND c.cpf LIKE '0%'
                          AND ca.data_lancamento >= '2021-01-01'
                          AND ca.data_lancamento < '2022-01-01'
                          AND NOT EXISTS (
                                          SELECT 1
                                          FROM vendas v3
                                            INNER JOIN carros ca2 ON ca2.idcarro = v3.idcarro
                                          WHERE v3.idcliente = c.idcliente
                                            AND ca2.modelo = 'Marea'
                                          GROUP BY v3.idcliente
                                          HAVING COUNT(*) >= 2
                                          )
                        ORDER BY v2.data_venda ASC
                        LIMIT 15
                        ) AS clientes_sorteados
                  WHERE clientes_sorteados.idcliente = v.idcliente
                  );

