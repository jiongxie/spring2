package com.spring.cjs200805.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.cjs200805.vo.PdsmVo;

public interface PdsmService {

	public List<PdsmVo> pmList(int startNo, int pageSize, String part);

	public void pmInput(MultipartHttpServletRequest file, PdsmVo vo);
	
	public void setDownCheck(int idx);

	public void setPmDeleteGet(int idx);


}
