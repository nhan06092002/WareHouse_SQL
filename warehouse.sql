--Xem giá các đơn hàng nhập kho
SELECT wsit.PurchaseOrderID,wsit.TransactionOccurredWhen as Purchase_Date,
SUM(wsit.Quantity * wsi.UnitPrice) AS gia_tri_nhap_kho
FROM Warehouse.StockItemTransactions wsit
JOIN Warehouse.StockItems wsi ON wsit.StockItemID = wsi.StockItemID
WHERE wsit.TransactionTypeID = 11
group by wsit.PurchaseOrderID,wsit.TransactionOccurredWhen
order by 1,2

--Tính giá các đơn hàng xuất kho
SELECT wsit.PurchaseOrderID,wsit.TransactionOccurredWhen as Purchase_Date,
SUM(ABS(wsit.Quantity) * wsi.UnitPrice) AS gia_tri_xuat_kho
FROM Warehouse.StockItemTransactions wsit
JOIN Warehouse.StockItems wsi ON wsit.StockItemID = wsi.StockItemID
WHERE wsit.TransactionTypeID = 10
group by wsit.PurchaseOrderID,wsit.TransactionOccurredWhen
order by 1,2

--Tính doanh thu của từng đơn hàng
select InvoiceID, Quantity*UnitPrice as Revenue
from Sales.InvoiceLines
order by 1

--Lấy danh sách đọt xuất kho gần nhất 
SELECT TOP 10 *
FROM Warehouse.StockItemTransactions
WHERE TransactionTypeID = 10
ORDER BY TransactionOccurredWhen DESC

--Mã hàng nào xuất kho nhiều nhất
SELECT StockItemID, SUM(ABS(Quantity)) AS TotalQuantity
FROM Warehouse.StockItemTransactions
WHERE TransactionTypeID = 10
GROUP BY StockItemID
ORDER BY TotalQuantity DESC

--Số lượng tồn kho của mỗi mã hàng 
SELECT SI.StockItemID, ws.StockItemName, SI.QuantityOnHand
FROM Warehouse.StockItemHoldings SI
join Warehouse.StockItems ws on SI.StockItemID=ws.StockItemID

--Lấy danh sách các mặt hàng có số lượng tồn kho dưới mức tối thiểu
SELECT SI.StockItemID, SI.StockItemName, WSH.QuantityOnHand,WSH.ReorderLevel,WSH.TargetStockLevel
FROM Warehouse.StockItems SI
INNER JOIN Warehouse.StockItemHoldings WSH ON SI.StockItemID = WSH.StockItemID
WHERE WSH.QuantityOnHand < WSH.ReorderLevel

--Lấy thông rin tất cả các đơn hàng nhập bới Fabrikam, Inc.O
SELECT SI.StockItemID, SI.StockItemName, ST.TransactionOccurredWhen
FROM Warehouse.StockItemTransactions ST
INNER JOIN Warehouse.StockItems SI ON ST.StockItemID = SI.StockItemID
INNER JOIN Purchasing.Suppliers S ON ST.SupplierID = S.SupplierID
WHERE ST.TransactionTypeID = 11 AND S.SupplierName = 'Fabrikam, Inc.'

