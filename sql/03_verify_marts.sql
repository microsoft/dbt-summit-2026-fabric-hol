SELECT TOP 20 * FROM jaffle_shop_dbo.fct_sales ORDER BY order_date DESC,sales_amount DESC;
SELECT customer_name,SUM(sales_amount) revenue FROM jaffle_shop_dbo.fct_sales GROUP BY customer_name ORDER BY revenue DESC;
