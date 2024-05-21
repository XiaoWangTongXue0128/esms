<%@page contentType="text/html;charset=utf-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/myCart_style.css" rel="stylesheet" type="text/css"/>
<title>无标题文档</title>
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript">
		function subBtn(liBtn) {
			var carInput = $(liBtn).next().find("input");
			var subvalue=carInput.val();

			if (subvalue == 1) {
				return;
			}
			carInput.val(--subvalue);
			$.ajax({
				url: "changeQuantity",
				type: "post",
				data: {
					product_id: $(liBtn).parent().parent().parent().parent().children().first().html(),
					count: subvalue
				},
				dataType: "json",
				success:function (value) {
					$("#cartBottom_price").html(value.sum_price);

				}
			});
		}

		function addBtn(liBtn) {
			var carInput = $(liBtn).prev().find("input");
			var addvalue=carInput.val();
			carInput.val(++addvalue);

			$.ajax({
				url: "changeQuantity",
				type: "post",
				data: {
					product_id: $(liBtn).parent().parent().parent().parent().children().first().html(),
					count: addvalue
				},
				dataType: "json",
				success:function (value) {
					$("#cartBottom_price").html(value.sum_price);

				}
			});
		}

		function ChangeQuantity(product_id,inputBtn) {
			var count = $(inputBtn).val();
			$.ajax({
				url: "changeQuantity",
				type: "post",
				data: {
					product_id: product_id,
					count: count
				},
				dataType: "json",
				success:function (value) {
					$("#cartBottom_price").html(value.sum_price);

				}
			});
		}

		function deleteProduct(product_id,deleteBtn){

			$.ajax({
				url: "deleteProduct",
				type: "post",
				data:{
					product_id: product_id
				},
				dataType: "json",
				success:function (value) {
					if (value.status == true) {
						var trEle=$(deleteBtn).parent();
						var trEleData = '<tr><td style="width: 70px;">'+
								trEle.find("td:eq(0)").html()+
								'</td><td style="text-align: left;"><a href="#">'+
								trEle.find("td:eq(1)").html()+
								'</a></td><td style="width: 150px;"><span class="price">￥'+
								trEle.find("td:eq(2)").html()+
								'</span></td><td style="width: 125px;">'+
								trEle.find("td:eq(5)").html()+
								'</td><td style="width: 100px;"><a href="#">重新购买</a> | <a href="#">收藏</a></td></tr>';
						trEle.remove();
						$("#cartBottom_price").html(value.sum_price);

						$("#DeledSkuInfo table").append(trEleData);
					}

				}
			})
		}
	</script>

</head>
<body>
<!------------头部------------->
<%@include file="head1.jsp" %>

<div id="bodyPart">
	<div id="top">
		<div id="logo"></div>
		<div id="Cart">
			<ul>
				<li id="myCart" class="white">1.我的购物车</li>
				<li id="writeInfo">2.填写核对订单信息</li>
				<li id="successSub">3.成功提交订单</li>				
			</ul>
		</div>
	</div>
	<div id="top_myCart"></div>
	<div class="List_cart">
		<h2>
			<strong>我挑选的商品</strong>
		</h2>
		<div class="cart_table">

			<table id="CartTb" cellpadding="0" cellspacing="0" width="600">
				<tr class="align_Right">
					<td>商品编号</td>
					<td>商品名称</td>
					<td>京东价</td>
					<td>返现</td>
					<td>赠送积分</td>
					<td>商品数量</td>
					<td>删除商品</td>
				</tr>


				<c:forEach items="${sessionScope.cart}" var="jdCartItem">
					<tr>
						<td>${jdCartItem.value.product_id}</td>
						<td id="align_Left">
							<div id="c_img"><a href="ipad.jsp"><img src="${jdCartItem.value.picture}" width="50px"></a></div>

							<div id="c_info"><span><a href="#">${jdCartItem.value.name}</a></span></div>
						</td>
						<td class="price">￥${jdCartItem.value.lower_price}</td>
						<td>￥${jdCartItem.value.back_money}</td>
						<td>${jdCartItem.value.score}</td>
						<td width="70">
							<div id="eqNum">
								<ul>
									<li class="Img" onclick="subBtn(this)"><img src="img/bag_close.gif"/></li>
									<li><input type="text" value="${jdCartItem.value.product_count}"  id="num" onchange="ChangeQuantity(${jdCartItem.value.product_id},this)" onfocus="this.select()"/></li>
									<li class="Img" onclick="addBtn(this)"><img src="img/bag_open.gif"/></li>

								</ul>
							</div>
						</td>
						<td onclick="deleteProduct(${jdCartItem.value.product_id},this)">删除</td>
					</tr>
				</c:forEach>

				<tr>
					<td colspan="7" class="align_Right" height="40"><b>商品总金额(不含运费)：<span id="cartBottom_price" class="price">￥${sum_price}</span>元</b></td>
				</tr>
			</table>

			<div id="cart_op">
				<ul>
					<li id="li1">寄存购物车</li>
					<li id="li2">清空购物车</li>
					<li id="li3">凑单商品</li>
					<li id="li4"><a onclick="javascript:window.history.go(-2);"><img src="img/btn0603_1.jpg"/></a><a href="orderInfoSure"><img src="img/btn0603_2.jpg"/></a></li>
				</ul>
			</div>
			
			<div id="DeledSkuInfo">
				<div>已删除商品，您可以重新购买或加入收藏夹：</div>
				<div id="divDeledSku">
					<div class="delItem">
						<table class="delItem">

						</table>
					</div>
				</div>
			</div>

		</div><!---cart_table--->
	</div>
	
	<div id="sbox_3" class="Wrap_cart">
		<div class="c-top"></div>	
		<div class="content_right">
			<h3>购买了同样商品的顾客还购买了</h3>		
			<ul class="num">
				<li>1</li>
				<li>2</li>
				<li class="on">3</li>
			</ul>
			<div class="ad">
				<ul>
					<li class="Product_List_S3">
						<ul>
							<li>
								<dl>
									<dt><a href="#"><img src="img/ms.jpg"></a></dt>
									<dd>
										<div class="p_Name"><a href="#">微软（Microsoft）无线激光鼠标ARC 黑色</a></div>
										<div class="p_Price"><img src="img/ms_price.png"></div>
										<div class="p_Opp"><a href="#"><img src="img/addcart2.gif"></a></div>

									</dd>
								</dl>
							</li>						
							<li>
								<dl>
									<dt><a href="#"><img src="img/ms.jpg"></a></dt>
									<dd>
										<div class="p_Name"><a href="#">微软（Microsoft）无线激光鼠标ARC 黑色</a></div>
										<div class="p_Price"><img src="img/ms_price.png"></div>
										<div class="p_Opp"><a href="#"><img src="img/addcart2.gif"></a></div>

									</dd>
								</dl>
							</li>						
							<li>
								<dl>
									<dt><a href="#"><img src="img/ms.jpg"></a></dt>
									<dd>
										<div class="p_Name"><a href="#">微软（Microsoft）无线激光鼠标ARC 黑色</a></div>
										<div class="p_Price"><img src="img/ms_price.png"></div>
										<div class="p_Opp"><a href="#"><img src="img/addcart2.gif"></a></div>

									</dd>
								</dl>
							</li>						
						</ul>
					</li>
				</ul>			
			</div>			
		</div>
		<div class="c-bot"></div>		
		
			
	</div>
	
	<div class="List_cart t">
		<h2>
			<strong>我收藏的商品<span id="smallSize">(现在就放入购物车吧！)</span><span id="extra">进入收藏夹>></span></strong>
		</h2>
		<div id="notFav">
			您还未收藏任何商品...
		</div>
	</div>
	<div id="help">
		帮我们改进购物车	</div>	
</div>
<!-- 页脚1 -->
<%@include file="footer1.jsp" %>

</body>
</html>
