package com.spring.cjs200805.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs200805.vo.CmemberVo;

public interface CmemberDao {

	public CmemberVo getIdCheck(@Param("mid") String mid, @Param("pwd") int pwd);

}
