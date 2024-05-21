package com.duyi.controller;

import com.duyi.bean.JdCategory;
import com.duyi.bean.JdProduct;
import com.duyi.bean.vo.BookList;
import com.duyi.service.JdCategoryService;
import com.duyi.service.JdProductService;
import com.duyi.util.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Controller
public class JdCategoryController {
    @Autowired
    private JdCategoryService jdCategoryService;
    @Autowired
    private JdProductService jdProductService;

    @RequestMapping("/bookList")
    public String toBookList(int parentId , HttpServletRequest request) {
//        获取小说、文学等的子目录
        List<JdCategory> jdCategoryList = jdCategoryService.selectByParentId(parentId);

////        获取当前目录名称：小说、文学等
//        JdCategory category = jdCategoryService.selectByPrimaryKey(parentId);

        request.setAttribute("jdCategoryList",jdCategoryList);
//        获取展示页面的只有个子分类ID
        int categoryId = jdCategoryList.isEmpty() ? -1 : jdCategoryList.get(0).getCategoryId();

        request.setAttribute("categoryId", categoryId);
        String order_std = Const.order_std;
        String order_type = Const.order_type;
        int start_pos = Const.start_pos;
        int page_size = Const.page_size;
        List<JdProduct> jdProductList = jdProductService.selectProductList(categoryId, order_std, order_type, start_pos, page_size);
        request.setAttribute("jdProductList", jdProductList);
        int sumPages = (jdProductService.selectProductSum(categoryId) + page_size - 1) / page_size;

        request.setAttribute("sumPages", sumPages);
        return "book_list";
    }

    @RequestMapping("/bookListAJAX")
    @ResponseBody
    public List<JdProduct> bookListAJAX(BookList bookList) {

        List<JdProduct> jdProductList = jdProductService.selectProductList(bookList.getCategoryId(),
                bookList.getOrder_std(),
                bookList.getOrder_type(),
                bookList.getStart_pos(),
                bookList.getPage_size());



        return jdProductList;
    }
}
