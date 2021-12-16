package com.spring.cjs200805.service;

import java.util.List;

import com.spring.cjs200805.vo.MemberVo;

public interface AdminService {

	public int totMemberRecCnt();

	public List<MemberVo> mList(int startNo, int pageSize);

	public void levelCheck(String mid, int level);

	public MemberVo mSearchList(String mid);

	public void memberDelete(int idx);

	public int imgDelete(String uploadPath);

}
