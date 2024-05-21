<%@page contentType="text/html;charset=utf-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>京东商城 - 图书频道首页</title>
<link rel="stylesheet" type="text/css" href="css/book.css" />
<link rel="stylesheet" type="text/css" href="css/book_list.css" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/bootstrap-paginator.js"></script>
    <script type="text/javascript">
        var frist_jdCategoryId = -1;
        var order_std = "print_int";
        var order_type = "desc";
        var start_pos = 0;
        var page_size = 4;
        $(function () {
            $(".item.tab li ").on("click", function () {
                frist_jdCategoryId = $("#categoryId").val();


                order_std = $(this).attr("name");
                var classStr = $(this).attr("class");
                if (classStr.indexOf("up") !=-1) {
                    classStr = classStr.replace("up", "down");
                    order_type = "asc";
                } else if (classStr.indexOf("down")!=-1) {
                    classStr = classStr.replace("down", "up");
                    order_type = "desc";
                } else {
                    classStr += "down";
                    order_type = "desc";
                }
                $(this).attr("class", classStr);
                //    去掉id='filter-curr'(选中效果)
                $(".item.tab li").removeAttr("id", "filter-curr");
                //给当前id增加id='filter-curr'(选中效果)
                $(this).attr("id", "filter-curr");
                $.ajax({
                    url: "bookListAJAX",
                    type:"post",
                    success:function (jdProductList) {
                        //拼接booklist的html
                        var str ='';
                        for(var i=0;i < jdProductList.length;i++){
                            var d = jdProductList[i];
                            var date = new Date(d.publishTime);
                            var y = date.getFullYear();
                            var m = date.getMonth() + 1;
                            m = m < 10 ? ('0' + m) : m;
                            var date1 = date.getDate();
                            date1 = date1 < 10 ? ('0' + date1) : date1;

                            var timeStr = y+"-"+m+"-"+date1;

                            str+='<div class="pro_item">';
                            str+='<div class="pro_picture"><a href="${pageContext.request.contextPath }/bookDetail.do?&productId='+d.productId+'"><img src="'+d.picture+'" /></a></div>'
                            str+='<div class="pro_info">';
                            str+='<div class="pro_up">';
                            str+='<div class="bookName"><a href="${pageContext.request.contextPath }/bookDetail.do?&productId='+d.productId+'"  style="display: inline-block;width: 600px;overflow: hidden;">'+d.name+'</a></div>';
                            str+='<div class="author">作&nbsp;&nbsp;&nbsp;&nbsp;者：<span>'+d.author+'</span> 著，译<br />出&nbsp;版&nbsp;社：<span>'+d.publishing+'</span><br /></div>';
                            str+='</div>';
                            str+='<div class="pro_down">';
                            str+='<div class="pro_left">';
                            str+='出版时间：' + timeStr;
                            str+='定&nbsp;&nbsp;&nbsp;&nbsp;价：￥'+d.fixedPrice+'';
                            str+='</div>';
                            str+='<div class="pro_right">';
                            str+=' 顾客评价：<span class="star" style="display:inline-block;width:65px;background-position-x: -'+(5-jdProductList[i].score)*13+'px;"></span>（<a href="${pageContext.request.contextPath }/commentView.do?productId='+d.productId+'"><span>已有'+123+'人评价<span></a>）<br />';
                            str+=' 销量：<b><font>￥'+d.printInt+'</font></b><span class="user_price"></span> 京东价：<b>￥'+d.lowerPrice+'</b>（'+Math.ceil(d.lowerPrice/d.fixedPrice*100)+'折)';
                            str+='</div>';
                            str+='</div>';
                            str+='<div class="clear"></div>';
                            str+='<div class="book_btn">';
                            str+='<a href="${pageContext.request.contextPath}/toAddCart?productId='+d.productId+'" class="buy"></a><input type="button" value="收藏" class="favorite" onclick="addCollection(this)" name="'+d.productId+'"/><h2 style="padding:4px;color:red;"></h2>';
                            str+='</div>';
                            str+='</div>';
                            str+='</div>';
                        }
                        //将列表设置到页面上

                        $(".product_list").html(str);
                    },
                    data:{
                        categoryId : frist_jdCategoryId,
                        order_std :order_std,
                        order_type :order_type,
                        start_pos :start_pos,
                        page_size :page_size
                    },
                    dataType:"json"

                });
            });
        });
    </script>
    <script type="text/javascript">
        $(function(){
            var  sumPages = $("#sumPages").val();
            var options={
                bootstrapMajorVersion:1,    //版本
                currentPage:1,    //当前页数
                numberOfPages:sumPages < page_size?sumPages : page_size,    //最多显示Page页
                totalPages:sumPages,    //所有数据可以显示的页数
                onPageClicked:function(e,originalEvent,type,page){
                    //page：当前页页码
                    console.log(page);
                    // 发送ajax 请求
                    //  给frist_jdCategoryId 再次赋值
                    frist_jdCategoryId = $("#categoryId").val();
                    $.ajax({
                        url:"bookListAJAX",
                        type:"post",
                        success:function (jdProductList) {
                            //拼接booklist的html
                            var str ='';
                            for(var i=0;i < jdProductList.length;i++){
                                var d = jdProductList[i];
                                var date = new Date(d.publishTime);
                                var y = date.getFullYear();
                                var m = date.getMonth() + 1;
                                m = m < 10 ? ('0' + m) : m;
                                var date1 = date.getDate();
                                date1 = date1 < 10 ? ('0' + date1) : date1;

                                var timeStr = y+"-"+m+"-"+date1;

                                str+='<div class="pro_item">';
                                str+='<div class="pro_picture"><a href="${pageContext.request.contextPath }/bookDetail.do?&productId='+d.productId+'"><img src="'+d.picture+'" /></a></div>'
                                str+='<div class="pro_info">';
                                str+='<div class="pro_up">';
                                str+='<div class="bookName"><a href="${pageContext.request.contextPath }/bookDetail.do?&productId='+d.productId+'"  style="display: inline-block;width: 600px;overflow: hidden;">'+d.name+'</a></div>';
                                str+='<div class="author">作&nbsp;&nbsp;&nbsp;&nbsp;者：<span>'+d.author+'</span> 著，译<br />出&nbsp;版&nbsp;社：<span>'+d.publishing+'</span><br /></div>';
                                str+='</div>';
                                str+='<div class="pro_down">';
                                str+='<div class="pro_left">';
                                str+='出版时间：' + timeStr;
                                str+='定&nbsp;&nbsp;&nbsp;&nbsp;价：￥'+d.fixedPrice+'';
                                str+='</div>';
                                str+='<div class="pro_right">';
                                str+=' 顾客评价：<span class="star" style="display:inline-block;width:65px;background-position-x: -'+(5-jdProductList[i].score)*13+'px;"></span>（<a href="${pageContext.request.contextPath }/commentView.do?productId='+d.productId+'"><span>已有'+123+'人评价<span></a>）<br />';
                                str+=' 销量：<b><font>￥'+d.printInt+'</font></b><span class="user_price"></span> 京东价：<b>￥'+d.lowerPrice+'</b>（'+Math.ceil(d.lowerPrice/d.fixedPrice*100)+'折)';
                                str+='</div>';
                                str+='</div>';
                                str+='<div class="clear"></div>';
                                str+='<div class="book_btn">';
                                str+='<a href="${pageContext.request.contextPath}/toAddCart?productId='+d.productId+'" class="buy"></a><input type="button" value="收藏" class="favorite" onclick="addCollection(this)" name="'+d.productId+'"/><h2 style="padding:4px;color:red;"></h2>';
                                str+='</div>';
                                str+='</div>';
                                str+='</div>';
                            }
                            //将列表设置到页面上
                            $(".product_list").html(str);
                        },
                        data:{
                            categoryId : frist_jdCategoryId,
                            order_std :order_std,
                            order_type :order_type,
                            start_pos :(page-1)*page_size,
                            page_size :page_size
                        },
                        dataType:"json"
                    });
                }
            }
            $("#page").bootstrapPaginator(options);
        })
    </script>
</head>
<body id="book">
<!--快捷访问栏开始-->
<%@include file="head.jsp"%>
<!--头部导航结束-->
<div class="clear"></div>
<!--位置-->
<div id="position" class="page_width">
	<ul>
     	<li><a href="#">首页</a></li>
        <li>&gt;</li>
     	<li><a href = "#">图书</a></li>
        <li>&gt;</li>
     	<li><a href="#">小说</a></li>
        <li>&gt;</li>
     	<li><a href="#">中国当代小说</a></li>
     </ul>
</div>
<!--主体main部分开始-->
<div class="clear"></div>

<div id="main" class="page_width">
<!--左侧开始-->
	<div id="left_list">
    	<div id="same_sort">
			<div class="book_tit" style="width:209px;"><h2>浏览同级分类<br /><span>Browse other categories</span></h2></div>
				<div class="book_content">
					<ul>
                        <c:forEach items="${jdCategoryList}" var="jdCategory">
                            <li><a href='bookList?parentId=${jdCategory.categoryId}'>${jdCategory.name}</a></li>
                        </c:forEach>

					</ul>
                    <div class="clear"></div>
					<div class="extra"><a href="#">返回上级分类&gt;&gt;</a></div>
				</div>
			</div>	
			
            <div class="books">
			<div class="book_title">
				<h2>新书推荐<br /><span>New Releases</span></h2>
			</div>
			<div class="book_info">					
                <div class="book_pic">
                    <div class=""><a href="bookDetail.jsp" target="_blank"><img src="img/book_59.jpg"/></a></div>
                </div>
                <div class="book_text">
                    <div class="book_name"><a href="bookDetail.jsp" target="_blank"><font color="#FF0000">《古炉》（贾平凹）</font></a></div>
                    <div class="book_intr">　　《&lt;古炉&gt;（贾平凹）》的故事发生在陕西一个叫“古...</div>
                    <div class="book_more"><a href="#" target="_blank">深度了解&gt;&gt;</a></div>
                </div>	
			</div>
			<div class="book_info">					
                <div class="book_pic">
                    <div class=""><a href="bookDetail.jsp" target="_blank"><img src="img/book_59.jpg"/></a></div>
                </div>
                <div class="book_text">
                    <div class="book_name"><a href="bookDetail.jsp" target="_blank"><font color="#FF0000">《古炉》（贾平凹）</font></a></div>
                    <div class="book_intr">　　《&lt;古炉&gt;（贾平凹）》的故事发生在陕西一个叫“古...</div>
                    <div class="book_more"><a href="#" target="_blank">深度了解&gt;&gt;</a></div>
                </div>	
			</div>
			<div class="book_info">					
                <div class="book_pic">
                    <div class=""><a href="bookDetail.jsp" target="_blank"><img src="img/book_59.jpg"/></a></div>
                </div>
                <div class="book_text">
                    <div class="book_name"><a href="bookDetail.jsp" target="_blank"><font color="#FF0000">《古炉》（贾平凹）</font></a></div>
                    <div class="book_intr">　　《&lt;古炉&gt;（贾平凹）》的故事发生在陕西一个叫“古...</div>
                    <div class="book_more"><a href="#" target="_blank">深度了解&gt;&gt;</a></div>
                </div>	
			</div>
			</div>
            
		
			<div class="ad_left_list">
            	<div class=""><a href="#" target="_blank"><img src="img/book_61.jpg" /></a></div>
				<div class=""><a href="#" target="_blank"><img src="img/book_47.jpg"></a></div>
			</div>

    </div>
<!--左侧结束-->

<!--右侧开始-->    
    <div id="right_list">
        <input type="hidden" value="${sumPages}" id="sumPages" />
    <input type="hidden" value="${categoryId}" id="categoryId"/>
		<div id="filter">
			<div class="fore item">排序：</div>
			<ul class="item tab">
                <li id='filter-curr' class='down' name="print_int"><b></b><a href="#">销售排行</a><span></span></li>
                <li class='up price' name="fixed_price"><b></b><a href="#">价格</a><span></span></li>
                <li  class="up discount" ><b></b><a href='#'>折扣</a><span></span></li>
                <li class="down"><b></b><a href='#'>好评度</a><span></span></li>
                <li  class='down' name="add_time"><b></b><a href='#'>上架时间</a><span></span></li>
                <li  class="down" name="publish_time"><b></b><a href='#'>出版时间</a><span></span></li>
			</ul>
			<span class="clear"></span>
		</div>
        
        <div class="page">
            <div id="page"></div>
		</div>
        
        <div class="clear"></div>
        
        <div class="product_list">
        	<c:forEach items="${jdProductList}" var="jdProduct">
                <div class="pro_item">
                    <div class="pro_picture"><a href="bookDetail.jsp"><img src="${jdProduct.picture}" /></a></div>
                    <div class="pro_info">
                        <div class="pro_up">
                            <div class="bookName"><a href="bookDetail.jsp">${jdProduct.name}</a></div>
                            <div class="author">作&nbsp;&nbsp;&nbsp;&nbsp;者：<span>${jdProduct.author}</span> 著，译<br />出&nbsp;版&nbsp;社：<span>${jdProduct.publishing}</span><br /></div>
                        </div>
                        <div class="pro_down">
                            <div class="pro_left">
                                出版时间：<th><fmt:formatDate value="${jdProduct.publishTime}" pattern="yyyy-MM-dd"/></th><br />
                                定&nbsp;&nbsp;&nbsp;&nbsp;价：￥${jdProduct.fixedPrice}
                            </div>
                            <div class="pro_right">
                                顾客评价：<span class="star">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>（<span>已有96人评价</span>）<br />
                                销量：<b>${jdProduct.printInt}</b><span class="user_price"></span> 京东价：<b>￥${jdProduct.lowerPrice}</b>（43折)
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="book_btn">
                            <a href="toAddCart?productId=${jdProduct.productId}" class="buy"></a><input type="button" value="收藏" class="favorite" />
                        </div>
                    </div>
                </div>
            </c:forEach>
            

              
        </div><!--列表结束-->

        <div class="page">
			<img src="images/page.jpeg" />
		</div>
          
    </div>
<!--右侧结束-->
</div>

<div class="clear"></div>
<!--服务部分开始-->
<%@include file="footer.jsp"%>
</body>
</html>
