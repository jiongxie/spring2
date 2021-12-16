package com.spring.cjs200805.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs200805.vo.BoardReplyVo;
import com.spring.cjs200805.vo.BoardVo;

public interface BoardDao {

	public void setBoardInput(@Param("vo") BoardVo vo);

	public List<BoardVo> getBoardList(@Param("startNo") int startNo, @Param("pageSize") int pageSize);

	public BoardVo getBoardContent(@Param("idx") int idx);

	public int totBoardRecCnt();

	public BoardVo passwordCheck(@Param("idx") int idx, @Param("pwd") String pwd);

	public void setBoardUpdate(@Param("vo") BoardVo vo);

	public void setBoardDelete(@Param("idx") int idx);  //일반변수는 생략가능하지만 써주는게 좋음

	public String maxLevelOrder(@Param("boardIdx") int boardIdx);

	public void setReplyInsert(@Param("cVo") BoardReplyVo cVo);

	public List<BoardReplyVo> getBoardReply(@Param("boardIdx") int boardIdx);

	public void setReplyDeleteGet(@Param("idx") int idx);

	public void levelOrderPlusUpdate(@Param("cVo") BoardReplyVo cVo);

	public void bContReplyInsert(@Param("cVo") BoardReplyVo cVo);

	public void readNumUpdate(@Param("idx") int idx);

	
}
