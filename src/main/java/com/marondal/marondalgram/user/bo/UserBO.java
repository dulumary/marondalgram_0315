package com.marondal.marondalgram.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondal.marondalgram.common.EncryptUtils;
import com.marondal.marondalgram.user.dao.UserDAO;
import com.marondal.marondalgram.user.model.User;

@Service
public class UserBO {
	
	@Autowired
	private UserDAO userDAO;

	public int signUp(String loginId, String password, String name, String email) {
		
		String encryptPassword = EncryptUtils.md5(password);	
		
		if(encryptPassword == null || encryptPassword.equals("")) {
		
			return 0;
		}
		
		return userDAO.insertUser(loginId, encryptPassword, name, email);
	}
	

	public User signIn(String loginId, String password) {
		// 비밀번호를 암호화 하고 DAO 로 전달한다. 
		String encryptPassword = EncryptUtils.md5(password);
		
		return userDAO.selectUser(loginId, encryptPassword);
	}
	
	public boolean isDuplicateId(String loginId) {
		
		int count = userDAO.selectCountLoginId(loginId);
		
//		if(count == 0) {
//			return false;
//		} else {
//			return true;
//		}
		
		return (count != 0);
		
	}
	
	
}
