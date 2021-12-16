package com.spring.cjs200805.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs200805.vo.PdsVo;

public interface PdsService {

	public List<PdsVo> getPList(int startNo, int pageSize, String part);

	public void setPdsUpload(MultipartFile file, PdsVo vo);

	public void setDownCopyCheck(PdsVo vo);

	public void setDownCheck(int idx);

}
