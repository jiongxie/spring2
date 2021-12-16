package com.spring.cjs200805.vo;

import lombok.Data;

public @Data class DbOrderVo {
  private int idx;
  private String orderIdx;
  private String mid;
  private int productIdx;
  private String orderDate;
  private String product;
  private int mainPrice;
  private String thumbImg;
  private String optionName;
  private String optionPrice;
  private String optionNum;
  private int totalPrice;
  
  private int cartIdx;  // 장바구니 고유번호.
  private int maxIdx;   // 주문번호를 구하기위한 기존 최대 비밀번호필드
}
