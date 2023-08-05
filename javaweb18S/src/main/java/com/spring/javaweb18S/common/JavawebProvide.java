package com.spring.javaweb18S.common;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

public class JavawebProvide {
	public int fileUpload(MultipartFile fName, String urlPath) {
		int res = 0;

		try {
			String oFileName = fName.getOriginalFilename();

			// 메모리에 올라와 있는 파일의 정보를 실제 서버 파일시스템에 저장
			writeFile(fName, oFileName, urlPath);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	public void writeFile(MultipartFile fName, String oFileName, String urlPath) throws IOException {
		byte[] data = fName.getBytes();
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");

		FileOutputStream fos = new FileOutputStream(realPath + oFileName);
		fos.write(data);
		fos.close();
	}
}
