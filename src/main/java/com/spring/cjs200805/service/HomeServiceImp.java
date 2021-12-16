package com.spring.cjs200805.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs200805.dao.HomeDao;
import com.spring.cjs200805.vo.NotifyVo;

@Service
public class HomeServiceImp implements HomeService {
	@Autowired
	HomeDao homeDao;

	@Override
	public List<NotifyVo> getNotifyPopup() {
		return homeDao.getNotifyPopup();
	}
}
