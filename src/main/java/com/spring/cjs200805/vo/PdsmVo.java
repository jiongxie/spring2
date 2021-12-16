package com.spring.cjs200805.vo;

import lombok.Data;

public @Data class PdsmVo {
  private int idx;
  private String mid;
  private String nickname;
  private String fname;
  private String rfname;
  private String title;
  private String part;
  private String pwd;
  private String fdate;
  private int fsize;
  private int downnum;
  private String opensw;
  private String content;
  
  // 멀티파일에 대한 정보를 저장하기위한 필드 2개
  private String fnames;
  private String rfnames;
}
