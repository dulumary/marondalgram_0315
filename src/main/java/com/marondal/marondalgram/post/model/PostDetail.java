package com.marondal.marondalgram.post.model;

import java.util.List;

import com.marondal.marondalgram.post.comment.model.Comment;

public class PostDetail {
	
	private Post post;
	private int likeCount;
	private List<Comment> commentList;
	private boolean isLike;
	
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public List<Comment> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
	public boolean isLike() {
		return isLike;
	}
	public void setLike(boolean isLike) {
		this.isLike = isLike;
	}
	
	
	
}
