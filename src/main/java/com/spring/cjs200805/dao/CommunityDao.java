package com.spring.cjs200805.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs200805.vo.CommunityVo;

public interface CommunityDao {

	public List<CommunityVo> getComList();

	public void setComInput(@Param("vo") CommunityVo vo);

	public void setComDeleteGet(@Param("idx") int idx, @Param("vo") CommunityVo vo);

	public void setComNDeleteGet(@Param("idx") int idx, @Param("vo") CommunityVo vo );
	
	public CommunityVo getComUpdateGet(@Param("idx") int idx);

	public void setComUpdatePost(@Param("vo") CommunityVo vo);

	public CommunityVo passwordCheck(@Param("idx") int idx, @Param("pwd") int pwd);

	public CommunityVo getComContentGet(@Param("idx") int idx);


}
