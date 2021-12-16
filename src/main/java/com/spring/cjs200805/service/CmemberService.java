package com.spring.cjs200805.service;

import com.spring.cjs200805.vo.CmemberVo;

public interface CmemberService {

	public CmemberVo getIdCheck(String mid, int pwd);

}
