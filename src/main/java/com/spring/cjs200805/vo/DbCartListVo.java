package com.spring.cjs200805.vo;

import lombok.Data;

public @Data class DbCartListVo {
  private int idx;
  private String cartDate;
  private String mid;
  private int productIdx;
  private String product;
  private int mainPrice;
  private String thumbImg;
  private String optionIdx;
  private String optionName;
  private String optionPrice;
  private String optionNum;
  private int totalPrice;
}
