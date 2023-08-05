package com.spring.javaweb18S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb18S.vo.CartVO;
import com.spring.javaweb18S.vo.DeliveryVO;
import com.spring.javaweb18S.vo.MainImageVO;
import com.spring.javaweb18S.vo.OptionVO;
import com.spring.javaweb18S.vo.OrderVO;
import com.spring.javaweb18S.vo.ProductVO;

public interface ShopDAO {

	public List<ProductVO> getCategoryArtist();

	public ProductVO getCategoryArtistOne(@Param("vo") ProductVO vo);

	public void setCategoryArtistInput(@Param("vo") ProductVO vo);

	public List<ProductVO> getCategoryProduct();

	public List<ProductVO> getCategoryArtistName(@Param("categoryMainCode") String categoryMainCode);

	public ProductVO getCategoryProductOne(@Param("vo") ProductVO vo);

	public void setCategoryProductInput(@Param("vo") ProductVO vo);

	public List<ProductVO> getCategorySubName(@Param("categoryArtistCode") String categoryArtistCode);

	public List<ProductVO> getCategoryProductName(@Param("categoryArtistCode") String categoryArtistCode, @Param("categoryProductCode") String categoryProductCode);

	public ProductVO getProductMaxIdx();

	public void setProductInput(@Param("vo") ProductVO vo);

	public List<ProductVO> getProductTitle();

	public List<ProductVO> getShopList(@Param("part") String part);

	public ProductVO getShopProduct(@Param("idx") int idx);

	public ProductVO getProductInfor(@Param("productName") String productName);

	public List<OptionVO> getOptionList(@Param("productIdx") int productIdx);

	public void setOptionInput(@Param("vo") OptionVO vo);

	public int getOptionSame(@Param("productIdx") int productIdx, @Param("optionName") String optionName);

	public void setOptionDelete(@Param("idx") int idx);

	public List<OptionVO> getShopOption(@Param("productIdx") int productIdx);

	public void setCategoryArtistDelete(@Param("categoryArtistCode") String categoryArtistCode);

	public ProductVO getProductOne(@Param("categoryProductCode") String categoryProductCode);

	public void setCategoryProductDelete(@Param("categoryProductCode") String categoryProductCode);

	public CartVO getCartProductOptionSearch(@Param("productName") String productName, @Param("optionName") String optionName, @Param("mid") String mid);

	public void cartUpdate(@Param("vo") CartVO vo);

	public void cartInput(@Param("vo") CartVO vo);

	public List<CartVO> getCartList(@Param("mid") String mid);

	public void cartDelete(@Param("idx") int idx);

	public CartVO getCartIdx(@Param("idx") int idx);

	public OrderVO getOrderMaxIdx();

	public void setOrder(@Param("vo") OrderVO vo);

	public void setCartDeleteAll(@Param("idx") int idx);

	public void setDelivery(@Param("deliveryVO") DeliveryVO deliveryVO);

	public List<DeliveryVO> getOrderDelivery(@Param("orderIdx") String orderIdx);

	public List<DeliveryVO> getMyOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public int totRecCnt(@Param("mid") String mid);

	public int totRecCntMyOrderStatus(@Param("mid") String mid, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("conditionOrderStatus") String conditionOrderStatus);

	public List<DeliveryVO> getMyOrderStatus(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("conditionOrderStatus") String conditionOrderStatus);

	public List<DeliveryVO> getOrderCondition(@Param("mid") String mid, @Param("conditionDate") int conditionDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCntAdminStatus(@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public int totRecCntMyOrderCondition(@Param("mid") String mid, @Param("conditionDate") int conditionDate);

	public List<MainImageVO> getMainImageSearch(@Param("productCode") String productCode);

	public List<MainImageVO> getMainImageList();

	public int mainImageInput(@Param("vo") MainImageVO vo);

	public int mainImageDelete(@Param("productCode") String productCode);

	public int setProductDelete(@Param("idx") int idx);

	public List<ProductVO> getShopListT();

}
