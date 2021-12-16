package com.spring.cjs200805.vo;

import lombok.Data;

public @Data class DbBaesongVo {
  private int idx;
  private String orderIdx;
  private int orderTotalPrice;
  private String mid;
  private String name;
  private String address;
  private String tel;
  private String message;
  private String payment;
  private String payMethod;
  private String orderStatus;
  
  // 아래는 주문테이블에서 사용된 필드리스트이다.
	private int productIdx;
	private String orderDate;
	private String product;
	private int mainPrice;
	private String thumbImg;
	private String optionName;
	private String optionPrice;
	private String optionNum;
	private int totalPrice;
}
