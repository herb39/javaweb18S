package com.spring.javaweb18S.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb18S.vo.DeliveryVO;
import com.spring.javaweb18S.vo.CartVO;
import com.spring.javaweb18S.vo.OptionVO;
import com.spring.javaweb18S.vo.OrderVO;
import com.spring.javaweb18S.vo.ProductVO;
import com.spring.javaweb18S.vo.MainImageVO;

public interface ShopService {

	public List<ProductVO> getCategoryArtist();

	public ProductVO getCategoryArtistOne(ProductVO vo);

	public void setCategoryArtistInput(ProductVO vo);

	public List<ProductVO> getCategoryProduct();

	public ProductVO getCategoryProductOne(ProductVO vo);

	public void setCategoryProductInput(ProductVO vo);

	public List<ProductVO> getCategorySubName(String categoryArtistCode);

	public List<ProductVO> getCategoryProductName(String categoryArtistCode, String categoryProductCode);

	public void imgCheckProductInput(MultipartFile file, ProductVO vo);

	public List<ProductVO> getProductTitle();

	public List<ProductVO> getShopList(String part);

	public ProductVO getShopProduct(int idx);

	public ProductVO getProductInfor(String productName);

	public List<OptionVO> getOptionList(int productIdx);

	public void setOptionInput(OptionVO vo);

	public int getOptionSame(int productIdx, String optionName);

	public void setOptionDelete(int idx);

	public List<OptionVO> getShopOption(int productIdx);

	public void setCategoryArtistDelete(String categoryArtistCode);

	public ProductVO getProductOne(String categoryProductCode);

	public void setCategoryProductDelete(String categoryProductCode);

	public CartVO getCartProductOptionSearch(String productName, String optionName, String mid);

	public void cartUpdate(CartVO vo);

	public void cartInput(CartVO vo);

	public List<CartVO> getCartList(String mid);

	public void cartDelete(int idx);

	public CartVO getCartIdx(int idx);

	public OrderVO getOrderMaxIdx();

	public void setOrder(OrderVO vo);

	public void setCartDeleteAll(int idx);

	public void setDelivery(DeliveryVO deliveryVO);

	public List<DeliveryVO> getOrderDelivery(String orderIdx);

	public List<DeliveryVO> getMyOrderList(int startIndexNo, int pageSize, String mid);

	public List<DeliveryVO> getMyOrderStatus(int startIndexNo, int pageSize, String mid, String startJumun, String endJumun, String conditionOrderStatus);

	public List<DeliveryVO> getOrderCondition(String mid, int conditionDate, int startIndexNo, int pageSize);

	public List<MainImageVO> getMainImageSearch(String productCode);

	public List<MainImageVO> getMainImageList();

	public int mainImageInput(MainImageVO vo, MultipartHttpServletRequest fName);

	public int mainImageDelete(String productCode);

	public int setProductDelete(int idx);

	public List<ProductVO> getShopListT();


}
