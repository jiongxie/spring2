package com.spring.cjs200805.service;

import java.util.List;

import com.spring.cjs200805.vo.CommunityVo;

public interface CommunityService {

	public List<CommunityVo> getComList();

	public void setComInput(CommunityVo vo);

	public void setComDeleteGet(int idx, CommunityVo vo);

	public void setComNDeleteGet(int idx, CommunityVo vo);
	
	public CommunityVo getComUpdateGet(int idx);

	public CommunityVo getComContentGet(int idx);
	
	public void setComUpdatePost(CommunityVo vo);

	public CommunityVo passwordCheck(int idx, int pwd);

	/* public void cmDeleteGet(int idx, int pwd); */

}
