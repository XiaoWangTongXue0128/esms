package com.duyi.bean.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BookList implements Serializable {

    private static final long serialVersionUID = -4340093374068970267L;
    private int categoryId;
    private String order_std;
    private String order_type;
    private int start_pos;
    private int page_size;
}
