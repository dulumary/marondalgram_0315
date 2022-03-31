package com.marondal.marondalgram.post.like.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeDAO {
	
	public int insertLike(
			@Param("postId") int postId,
			@Param("userId") int userId);
	
	public int deleteLike(
			@Param("postId") int postId,
			@Param("userId") int userId);
	
	public int selectLikeCount(@Param("postId") int postId);
	
	public int selectLikeCountByUserId(
			@Param("postId") int postId,
			@Param("userId") int userId);
	
	
}
