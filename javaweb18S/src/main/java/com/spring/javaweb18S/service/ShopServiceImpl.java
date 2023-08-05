package com.spring.javaweb18S.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb18S.dao.ShopDAO;
import com.spring.javaweb18S.vo.CartVO;
import com.spring.javaweb18S.vo.DeliveryVO;
import com.spring.javaweb18S.vo.MainImageVO;
import com.spring.javaweb18S.vo.OptionVO;
import com.spring.javaweb18S.vo.OrderVO;
import com.spring.javaweb18S.vo.ProductVO;

@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	ShopDAO shopDAO;

	@Override
	public List<ProductVO> getCategoryArtist() {
		return shopDAO.getCategoryArtist();
	}

	@Override
	public ProductVO getCategoryArtistOne(ProductVO vo) {
		return shopDAO.getCategoryArtistOne(vo);
	}

	@Override
	public void setCategoryArtistInput(ProductVO vo) {
		shopDAO.setCategoryArtistInput(vo);
	}

	@Override
	public List<ProductVO> getCategoryProduct() {
		return shopDAO.getCategoryProduct();
	}

	@Override
	public ProductVO getCategoryProductOne(ProductVO vo) {
		return shopDAO.getCategoryProductOne(vo);
	}

	@Override
	public void setCategoryProductInput(ProductVO vo) {
		shopDAO.setCategoryProductInput(vo);
	}

	@Override
	public List<ProductVO> getCategorySubName(String categoryArtistCode) {
		return shopDAO.getCategorySubName(categoryArtistCode);
	}

	@Override
	public List<ProductVO> getCategoryProductName(String categoryArtistCode, String categoryProductCode) {
		return shopDAO.getCategoryProductName(categoryArtistCode, categoryProductCode);
	}

	@Override
	public void imgCheckProductInput(MultipartFile file, ProductVO vo) {
		// 먼저 기본(메인)그림파일은 'dbShop/product'폴더에 복사 시켜준다.
		try {
			String originalFilename = file.getOriginalFilename();
			if(originalFilename != null && originalFilename != "") {
				// 상품 메인사진을 업로드처리하기위해 중복파일명처리와 업로드처리
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			  String saveFileName = sdf.format(date) + "_" + originalFilename;
				writeFile(file, saveFileName, "product");	  // 메일 이미지를 서버에 업로드 시켜주는 메소드 호출
				vo.setFSName(saveFileName);				// 서버에 저장된 파일명을 vo에 set시켜준다.
			}
			else {
				return;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//             0         1         2         3         4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/dbShop/211229124318_4.jpg"
		// <img alt="" src="/javawewS/data/dbShop/product/211229124318_4.jpg"
		
		// ckeditor을 이용해서 담은 상품의 상세설명내역에 그림이 포함되어 있으면 그림을 dbShop/product폴더로 복사작업처리 시켜준다.
		String content = vo.getContent();
		if(content.indexOf("src=\"/") == -1) return;		// content박스의 내용중 그림이 없으면 돌아간다.
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		// String uploadPath = request.getRealPath("/resources/data/dbShop/");
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/");
		
		int position = 27;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			
			copyFilePath = uploadPath + "product/" + imgFile;	// 복사가 될 '경로명+파일명'
			
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
		// 이미지 복사작업이 종료되면 실제로 저장된 'dbShop/product'폴더명을 vo에 set시켜줘야 한다.
		vo.setContent(vo.getContent().replace("/data/shop/", "/data/shop/product/"));

		// 파일 복사작업이 모두 끝나면 vo에 담긴내용을 상품의 내역을 DB에 저장한다.
		// 먼저 productCode를 만들어주기 위해 지금까지 작업된 dbProduct테이블의 idx필드중 최대값을 읽어온다. 없으면 0으로 처리한다.
		int maxIdx = 1;
		ProductVO maxVo = shopDAO.getProductMaxIdx();
		if(maxVo != null) {
			maxIdx = maxVo.getIdx() + 1;
			vo.setIdx(maxIdx);
		}
		vo.setProductCode(vo.getCategoryArtistCode()+vo.getCategoryProductCode()+maxIdx);
		//System.out.println("vo : " + vo);
		shopDAO.setProductInput(vo);
	}
	
  // 실제 파일(dbShop폴더)을 'dbShop/product'폴더로 복사처리하는곳
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream  fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 메인 상품 이미지 서버에 저장하기
	private void writeFile(MultipartFile fName, String saveFileName, String flag) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String readPath = "";
		if(flag.equals("product")) {
			readPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/product/");
		}
		else if(flag.equals("mainImage")) {
			readPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/mainImage/");
		}
		
		FileOutputStream fos = new FileOutputStream(readPath + saveFileName);
		fos.write(data);
		fos.close();
	}

	@Override
	public List<ProductVO> getProductTitle() {
		return shopDAO.getProductTitle();
	}

	@Override
	public List<ProductVO> getShopList(String part) {
		return shopDAO.getShopList(part);
	}

	@Override
	public ProductVO getShopProduct(int idx) {
		return shopDAO.getShopProduct(idx);
	}

	@Override
	public ProductVO getProductInfor(String productName) {
		return shopDAO.getProductInfor(productName);
	}

	@Override
	public List<OptionVO> getOptionList(int productIdx) {
		return shopDAO.getOptionList(productIdx);
	}

	@Override
	public void setOptionInput(OptionVO vo) {
		shopDAO.setOptionInput(vo);
	}

	@Override
	public int getOptionSame(int productIdx, String optionName) {
		return shopDAO.getOptionSame(productIdx, optionName);
	}

	@Override
	public void setOptionDelete(int idx) {
		shopDAO.setOptionDelete(idx);
	}

	@Override
	public List<OptionVO> getShopOption(int productIdx) {
		return shopDAO.getShopOption(productIdx);
	}

	@Override
	public void setCategoryArtistDelete(String categoryArtistCode) {
		shopDAO.setCategoryArtistDelete(categoryArtistCode);
	}

	@Override
	public ProductVO getProductOne(String categoryProductCode) {
		return shopDAO.getProductOne(categoryProductCode);
	}

	@Override
	public void setCategoryProductDelete(String categoryProductCode) {
		shopDAO.setCategoryProductDelete(categoryProductCode);
	}

	@Override
	public CartVO getCartProductOptionSearch(String productName, String optionName, String mid) {
		return shopDAO.getCartProductOptionSearch(productName, optionName, mid);
	}

	@Override
	public void cartUpdate(CartVO vo) {
		shopDAO.cartUpdate(vo);
	}

	@Override
	public void cartInput(CartVO vo) {
		shopDAO.cartInput(vo);
	}

	@Override
	public List<CartVO> getCartList(String mid) {
		return shopDAO.getCartList(mid);
	}

	@Override
	public void cartDelete(int idx) {
		shopDAO.cartDelete(idx);
	}

	@Override
	public CartVO getCartIdx(int idx) {
		return shopDAO.getCartIdx(idx);
	}

	@Override
	public OrderVO getOrderMaxIdx() {
		return shopDAO.getOrderMaxIdx();
	}

	@Override
	public void setOrder(OrderVO vo) {
		shopDAO.setOrder(vo);
	}

	@Override
	public void setCartDeleteAll(int idx) {
		shopDAO.setCartDeleteAll(idx);
	}

	@Override
	public void setDelivery(DeliveryVO deliveryVO) {
		shopDAO.setDelivery(deliveryVO);
	}

	@Override
	public List<DeliveryVO> getOrderDelivery(String orderIdx) {
		return shopDAO.getOrderDelivery(orderIdx);
	}

	@Override
	public List<DeliveryVO> getMyOrderList(int startIndexNo, int pageSize, String mid) {
		return shopDAO.getMyOrderList(startIndexNo, pageSize, mid);
	}

	@Override
	public List<DeliveryVO> getMyOrderStatus(int startIndexNo, int pageSize, String mid, String startJumun, String endJumun, String conditionOrderStatus) {
		return shopDAO.getMyOrderStatus(startIndexNo, pageSize, mid, startJumun, endJumun, conditionOrderStatus);
	}

	@Override
	public List<DeliveryVO> getOrderCondition(String mid, int conditionDate, int startIndexNo, int pageSize) {
		return shopDAO.getOrderCondition(mid, conditionDate, startIndexNo, pageSize);
	}

	@Override
	public List<MainImageVO> getMainImageSearch(String productCode) {
		return shopDAO.getMainImageSearch(productCode);
	}

	@Override
	public List<MainImageVO> getMainImageList() {
		return shopDAO.getMainImageList();
	}

	@Override
	public int mainImageInput(MainImageVO vo, MultipartHttpServletRequest fName) {
		int res = 0;
		try {
			List<MultipartFile> fileList = fName.getFiles("file");
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);
				System.out.println("oFileName : " + oFileName);
				// 파일을 서버에 저장처리...
				writeFile(file, sFileName, "mainImage");
				
				// 여러개의 파일을 DB에 각각의 레코드로 저장처리
				vo.setMainFName(sFileName);
				res = shopDAO.mainImageInput(vo);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	// 화일명 중복방지를 위한 저장파일명 만들기
	private String saveFileName(String oFileName) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
	  String saveFileName = sdf.format(date) + "_" + oFileName;
		
		return saveFileName;
	}

	@Override
	public int mainImageDelete(String productCode) {
		List<MainImageVO> mainFNames = shopDAO.getMainImageSearch(productCode);
		for(int i=0; ; i++) {
			
		}
		
//		return shopDAO.mainImageDelete(productCode);
	}

	@Override
	public int setProductDelete(int idx) {
		return shopDAO.setProductDelete(idx);
	}

	@Override
	public List<ProductVO> getShopListT() {
		return shopDAO.getShopListT();
	}

	
}
