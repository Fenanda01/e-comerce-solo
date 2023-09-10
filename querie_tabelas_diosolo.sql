-- Seleção da base completa de clientes
SELECT * FROM clients;

-- Seleção da base completa de estoques
SELECT * FROM warehouses;

-- Seleção de apenas uma ocorrência dos locais da base de estoques
SELECT DISTINCT Location FROM warehouses;

-- Mapeamento de estoques em São Paulo, a partir de uma condição
SELECT * FROM warehouses
WHERE Location = 'São Paulo';

-- Mapeamento de clientes na mesma região, por CEP
SELECT * FROM clients
WHERE ZipCode LIKE '04%';

-- Seleção de pedidos por cliente, trazendo a informação de status do pedido
SELECT CONCAT(c.Fname, ' ', c.Lname) AS Cliente, o.idOrder, o.OrStatus
FROM orders o
INNER JOIN clients c ON o.idClient = c.idClient;

-- Seleção dos itens de cada pedido
SELECT o.idPOrder AS idOrder, p.Pname AS Product, po.OQuantity AS Qtd, ROUND(p.UnPrice, 2) AS UnPrice, ROUND((po.OQuantity * p.UnPrice), 2) AS FinalPrice, po.POStatus
FROM productOrder po
INNER JOIN products p ON po.idPOproduct = p.idProduct;

-- Seleção de pedidos por cliente, com informação dos produtos do pedido
SELECT po.idPOrder AS idOrder, CONCAT(c.Fname, ' ', c.Lname) AS Cliente, p.Pname AS Product, po.OQuantity AS Qtd, ROUND(p.UnPrice, 2) AS UnPrice, ROUND((po.OQuantity * p.UnPrice), 2) AS FinalPrice, po.POStatus
FROM productOrder po
INNER JOIN products p ON po.idPOproduct = p.idProduct
INNER JOIN orders o ON po.idPOrder = o.idOrder
INNER JOIN clients c ON o.idClient = c.idClient
ORDER BY Cliente;

-- Confirmação de pagamento de pedido com o valor total e status do pagamento
SELECT po.idPOrder, CONCAT(c.Fname, ' ', c.Lname) AS Cliente, ROUND(SUM((po.OQuantity * p.UnPrice)), 2) AS FinalPrice, py.PayMethods, py.PayStatus
FROM productOrder po
INNER JOIN orders o ON po.idPOrder = o.idOrder
INNER JOIN clients c ON o.idClient = c.idClient
INNER JOIN payments py ON c.idClient = py.idClient
GROUP BY po.idPOrder, Cliente;

-- Classificação de vendedores por comissão
SELECT r.Rname, r.ZipCode, p.Pname, pr.RQuantity, ROUND((pr.RQuantity * p.UnPrice), 2) AS GrossPrice, ROUND((pr.RQuantity * p.UnPrice * 0.05), 2) AS Commission
FROM productRetailer pr
INNER JOIN products p ON pr.idPRproduct = p.idProduct
INNER JOIN retailers r ON pr.idPRetailer = r.idRetailer
ORDER BY Commission DESC;

-- Having Statement: Classificação de vendedores com 2+ produtos vendidos
SELECT r.Rname, r.ZipCode, p.Pname, COUNT(*) AS TotalSales, ROUND((pr.RQuantity * p.UnPrice), 2) AS GrossPrice, ROUND((pr.RQuantity * p.UnPrice * 0.05), 2) AS Commission
FROM productRetailer pr
INNER JOIN products p ON pr.idPRproduct = p.idProduct
INNER JOIN retailers r ON pr.idPRetailer = r.idRetailer
GROUP BY r.Rname
HAVING COUNT(*) > 1
ORDER BY Commission DESC;

-- Case Statement: Classificação dos estoques de fornecedores
-- Abaixo de 10 = Estoque Baixo
-- Igual a 10 = Estoque no Limite
-- Acima de 10 = Estoque Alto
SELECT s.Sname, s.ZipCode, p.Pname, ps.SQuantity,
CASE
    WHEN ps.SQuantity < 10 THEN 'Estoque Baixo'
    WHEN ps.SQuantity = 10 THEN 'Estoque no Limite'
    ELSE 'Estoque Alto'
END AS StockClassification
FROM productSupplier ps
INNER JOIN suppliers s ON ps.idPSupplier = s.idSupplier
INNER JOIN products p ON ps.idPSproduct = p.idProduct
ORDER BY ps.SQuantity DESC;

-- Join Statement 3 Tabelas: Classificação de vendedores de 'PC Gamer' por comissão
SELECT r.Rname, r.ZipCode, p.Pname, pr.RQuantity, ROUND((pr.RQuantity * p.UnPrice), 2) AS GrossPrice, ROUND((pr.RQuantity * p.UnPrice * 0.05), 2) AS Commission
FROM productRetailer pr
INNER JOIN products p ON pr.idPRproduct = p.idProduct
INNER JOIN retailers r ON pr.idPRetailer = r.idRetailer
WHERE p.Pname = 'PC Gamer'
ORDER BY Commission DESC;