package com.spring.cjs200805.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs200805.dao.CommunityDao;
import com.spring.cjs200805.vo.CommunityVo;

@Service
public class CommunityServiceImp implements CommunityService {
	@Autowired 
	CommunityDao communityDao;
	
	@Override
	public List<CommunityVo> getComList() {
		return communityDao.getComList();
	}

	@Override
	public void setComInput(CommunityVo vo) {
		communityDao.setComInput(vo);
	}

	@Override
	public void setComDeleteGet(int idx, CommunityVo vo) {
		communityDao.setComDeleteGet(idx, vo);
	}

	@Override
	public void setComNDeleteGet(int idx, CommunityVo vo) {
		communityDao.setComNDeleteGet(idx, vo);
	}
	
	
	@Override
	public CommunityVo getComUpdateGet(int idx) {
		return communityDao.getComUpdateGet(idx);
	}

	@Override
	public void setComUpdatePost(CommunityVo vo) {
		communityDao.setComUpdatePost(vo);
	}

	@Override
	public CommunityVo getComContentGet(int idx) {
		return communityDao.getComContentGet(idx);
	}
	
	
	@Override
	public CommunityVo passwordCheck(int idx, int pwd) {
		return communityDao.passwordCheck(idx, pwd);
	}



}
