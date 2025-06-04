                    <td>
                        <c:if test="${order.status == '已发货'}">
                            <form action="${pageContext.request.contextPath}/merchant/return/approve" method="post" style="display: inline;">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <button type="submit" class="btn-approve">同意退货</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/merchant/return/reject" method="post" style="display: inline;">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <button type="submit" class="btn-reject">拒绝退货</button>
                            </form>
                        </c:if>
                        <c:if test="${order.status != '已发货'}">
                            <a href="${pageContext.request.contextPath}/merchant/order/detail?id=${order.orderId}" class="btn-view">查看详情</a>
                        </c:if>
                    </td> 