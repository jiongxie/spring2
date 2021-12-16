package com.spring.cjs200805.service;

import java.util.List;

import com.spring.cjs200805.vo.NotifyVo;

public interface NotifyService {

	public void nInput(NotifyVo vo);

	public List<NotifyVo> getNotifyList();

	public void setDelete(int idx);

	public NotifyVo getNUpdate(int idx);

	public void setNUpdateOk(NotifyVo vo);

	public int setpopupCheckUpdate(int idx, String popupSw);

}
