-- cart_member, cart_prod
-- ==> ȸ���� īƮ ������, ��ǰ�� īƮ ������
SELECT cart_member, cart_prod, SUM(cart_qty) sum_cart_qty
FROM cart
GROUP BY GROUPING SETS (CART_MEMBER,CART_PROD);