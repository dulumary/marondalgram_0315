package com.marondal.marondalgram.post.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.marondal.marondalgram.common.FileManagerService;
import com.marondal.marondalgram.post.comment.bo.CommentBO;
import com.marondal.marondalgram.post.comment.model.Comment;
import com.marondal.marondalgram.post.dao.PostDAO;
import com.marondal.marondalgram.post.like.bo.LikeBO;
import com.marondal.marondalgram.post.model.Post;
import com.marondal.marondalgram.post.model.PostDetail;

@Service
public class PostBO {
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private LikeBO likeBO;
	
	@Autowired
	private CommentBO commentBO;
	
	public int addPost(int userId, String userName, String content, MultipartFile file) {
		
		String imagePath = FileManagerService.saveFile(userId, file);
		
		return postDAO.insertPost(userId, userName, content, imagePath);
		
	}
	
	public List<PostDetail> getPostList(int userId) {
		
		List<Post> postList = postDAO.selectPostList();
		
		List<PostDetail> postDetailList = new ArrayList<>();
		
		// 포스트 마다 댓글 좋아요 가져오기
		for(Post post : postList) {
			// 좋아요 개수 얻어 오기 post Id
			int likeCount = likeBO.getLikeCount(post.getId());
			
			// 댓글 리스트 가져오기 
			List<Comment> commentList = commentBO.getCommentList(post.getId());
			
			// 로그인한 사용자가 좋아요를 눌렀는지 여부
			boolean isLike = likeBO.isLike(post.getId(), userId);
			
			PostDetail postDetail = new PostDetail();
			postDetail.setPost(post);
			postDetail.setLikeCount(likeCount);
			postDetail.setCommentList(commentList);
			postDetail.setLike(isLike);
			
			postDetailList.add(postDetail);
		}
		
		return postDetailList;
	}
	
	public int deletePost(int postId, int userId) {
		

		// postId 로 Post 객체 얻어 오기 
		Post post = postDAO.selectPost(postId);
		
		if(post.getUserId() == userId) {
			// 파일 삭제
			FileManagerService.removeFile(post.getImagePath());
			
			// 댓글 삭제
			commentBO.deleteCommentByPostId(postId);
			
			// 좋아요 삭제
			likeBO.deleteLikeByPostId(postId);
			
			return postDAO.deletePost(postId);
		}
		
		return 0;
	}

}
