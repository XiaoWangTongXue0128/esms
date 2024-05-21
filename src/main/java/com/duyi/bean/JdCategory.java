package com.duyi.bean;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class JdCategory implements Serializable {

    private static final long serialVersionUID = 6731588941186881558L;
    private Integer categoryId;

    private String name;

    private Integer turn;

    private String description;

    private Integer parentId;


}