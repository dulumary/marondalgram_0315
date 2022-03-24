package com.marondal.marondalgram.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

public class FileManagerService {
	
	public final static String FILE_UPLOAD_PATH = "D:\\김인규 강사\\web\\0312\\springProject\\marondalgram\\upload\\images/";
	
	private static Logger logger = LoggerFactory.getLogger(FileManagerService.class);
	
	public static String saveFile(int userId, MultipartFile file) {
		
		if(file == null) {
			
			logger.error("FileManagerService-saveFile : 파일 없음");
			
			return null;
		}
		
		// 파일경로 
		// 파일이름이 겹치는 것을 방지하기 위해 사용자 별로 폴더를 구분한다.
		// 같은 사용자가 같은 파일이름 겹치는 것 방지를 위해서 현재 시간을 폴더이름에 포함시킨다.
		// UNIX time : 1970년 1월 1일 0시0분0초 기준으로 현재 몇 milliescond (1/1000초)가 지났는지 
		// /images/6_12912098/asdf.jpg
		
		String directoryName = userId + "_" + System.currentTimeMillis() + "/";
		
		//D:\\김인규 강사\\web\\0312\\springProject\\memo\\upload\\images/6_12912098/
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		// 디렉토리 생성 
		File directory = new File(filePath);
		if(directory.mkdir() == false) {
			// 디렉토리 생성 에러 
			logger.error("FileManagerService-saveFile : 디렉토리 생성 에러");
			return null;
		}
		
		// 파일 저장
		
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + file.getOriginalFilename());
			Files.write(path, bytes);
			
		} catch (IOException e) {
			
			e.printStackTrace();
			logger.error("FileManagerService-saveFile : 파일 저장 에러");
			return null;
		}
		
		// <img src="/images/6_12912098/test.png" >
		// /images/6_12912098/test.png
		return "/images/" + directoryName + file.getOriginalFilename();
		
	}

}
