package com.spring.cjs200805.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs200805.dao.CmemberDao;
import com.spring.cjs200805.vo.CmemberVo;

@Service
public class CmemberServiceImp implements CmemberService {

	@Autowired
	CmemberDao cmemberDao;
	
	@Override
	public CmemberVo getIdCheck(String mid,int pwd) {
		return cmemberDao.getIdCheck(mid, pwd);
	}

}
