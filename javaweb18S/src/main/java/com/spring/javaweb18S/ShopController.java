package com.spring.javaweb18S;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb18S.pagination.PageProcess;
import com.spring.javaweb18S.pagination.PageVO;
import com.spring.javaweb18S.service.MemberService;
import com.spring.javaweb18S.service.ShopService;
import com.spring.javaweb18S.vo.CartVO;
import com.spring.javaweb18S.vo.DeliveryVO;
import com.spring.javaweb18S.vo.MainImageVO;
import com.spring.javaweb18S.vo.MemberVO;
import com.spring.javaweb18S.vo.OptionVO;
import com.spring.javaweb18S.vo.OrderVO;
import com.spring.javaweb18S.vo.PaymentVO;
import com.spring.javaweb18S.vo.ProductVO;

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	MemberService memberService;
	
	// 분류 폼 보기
	@RequestMapping(value = "/category", method = RequestMethod.GET)
	public String categoryGet(Model model) {
		List<ProductVO> artistVOS = shopService.getCategoryArtist();
		List<ProductVO> productVOS = shopService.getCategoryProduct();
	
		model.addAttribute("artistVOS", artistVOS);
		model.addAttribute("productVOS", productVOS);
		
		return "admin/shop/category";
	}
	
	// 아티스트 분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categoryArtistInput", method = RequestMethod.POST)
	public String categoryArtistInputPost(ProductVO vo) {
		// 기존에 같은 중분류명이 있는지 체크?
		ProductVO productVO = shopService.getCategoryArtistOne(vo);
		
		if(productVO != null) return "0";
		shopService.setCategoryArtistInput(vo);		// 중분류항목 저장
		return "1";
	}
	
	// 중분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categoryArtistDelete", method = RequestMethod.POST)
	public String categoryArtistDeleteGet(ProductVO vo) {
		// 현재 중분류가 속해있는 하위항목이 있는지를 체크한다.
		ProductVO ProductVO = shopService.getCategoryProductOne(vo);
		
		if(ProductVO != null) return "0";
		shopService.setCategoryArtistDelete(vo.getCategoryArtistCode());  // 소분류항목 삭제
		
		return "1";
	}
	
  // 소분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categoryProductInput", method = RequestMethod.POST)
	public String categoryProductInputPost(ProductVO vo) {
		// 기존에 같은 소분류명이 있는지 체크?
		ProductVO productVO = shopService.getCategoryProductOne(vo);
		
		if(productVO != null) return "0";
		shopService.setCategoryProductInput(vo);		// 중분류항목 저장
		return "1";
	}
	
	// 소분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categoryProductDelete", method = RequestMethod.POST)
	public String categoryProductDeleteGet(ProductVO vo) {
		// 현재 소분류가 속해있는 하위항목인 상품이 있는지를 체크한다.
		ProductVO productVO = shopService.getProductOne(vo.getCategoryProductCode());
		
		if(productVO != null) return "0";
		shopService.setCategoryProductDelete(vo.getCategoryProductCode());  // 소분류항목 삭제
		
		return "1";
	}
	
	// 상품 등록을 위한 등록폼 보여주기
	@RequestMapping(value = "/product", method = RequestMethod.GET)
	public String productGet(Model model) {
		List<ProductVO> artistVOS = shopService.getCategoryArtist();
		model.addAttribute("artistVOS", artistVOS);
		return "admin/shop/product";
	}
	
	// 중분류 선택시에 소분류항목들 가져오기
	@ResponseBody
	@RequestMapping(value = "/categorySubName", method = RequestMethod.POST)
	public List<ProductVO> categoryProductPost(String categoryArtistCode) {
		return shopService.getCategorySubName(categoryArtistCode);
	}
	
	// 소분류 선택시에 상품명(모델명) 가져오기
	@ResponseBody
	@RequestMapping(value = "/categoryProductName", method = RequestMethod.POST)
	public List<ProductVO> categoryProductNamePost(String categoryArtistCode, String categoryProductCode) {
		return shopService.getCategoryProductName(categoryArtistCode, categoryProductCode);
	}
	
	// 관리자 상품등록시에 ckeditor에 그림을 올린다면 shop폴더에 저장되고, 저장된 파일을 브라우저 textarea상자에 보여준다. 
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/shop/" + originalFilename;
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		outStr.close();
	}
	
	// 상품 등록을 위한 등록시키기
	@RequestMapping(value = "/product", method = RequestMethod.POST)
	public String productPost(MultipartFile file, ProductVO vo) {
		// 이미지파일 업로드시에 ckeditor폴더에서 product폴더로 복사...(shop폴더에서 'shop/product'로)
		shopService.imgCheckProductInput(file, vo);
		
		return "redirect:/message/productInputOk";
	}
	
	// 등록된 상품 모두 보여주기(관리자화면에서 보여주는 처리부분) - 상품의 소분류명(ProductTitle)도 출력
	@RequestMapping(value = "/shopList", method = RequestMethod.GET)
	public String shopListGet(Model model,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part) {
		// 소분류명을 가져온다.
		List<ProductVO> productTitleVOS = shopService.getProductTitle();
		model.addAttribute("productTitleVOS", productTitleVOS);
		model.addAttribute("part", part);
		
		// 전체 상품리스트 가져오기
		List<ProductVO> productVOS = shopService.getShopList(part);
		model.addAttribute("productVOS", productVOS);
		
		return "admin/shop/shopList";
	}
	
	// 관리자에서 진열된 상품을 클릭했을 때 해당 상품의 상세내역 보여주기
	@RequestMapping(value="/shopContent", method = RequestMethod.GET)
	public String shopContentGet(Model model, int idx) {
		ProductVO productVO = shopService.getShopProduct(idx);	   // 1건의 상품 정보를 불러온다.
		List<OptionVO> optionVOS = shopService.getShopOption(idx); // 해당 상품의 모든 옵션 정보를 가져온다.
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		
		return "admin/shop/shopContent";
	}
	
	// 옵션 등록창 보여주기(관리자 왼쪽메뉴에서 선택시 처리)
	@RequestMapping(value = "/option", method = RequestMethod.GET)
	public String optionGet(Model model) {
		List<ProductVO> artistVOS = shopService.getCategoryArtist();
		model.addAttribute("artistVOS", artistVOS);
		
		return "admin/shop/option";
	}
	
	// 옵션 등록창 보여주기(관리자 상품상세보기에서 호출시 처리)
	@ResponseBody
	@RequestMapping(value = "/option2", method = RequestMethod.GET)
	public String option2Get(Model model, String productName) {
		ProductVO productVO = shopService.getProductInfor(productName);
		List<OptionVO> optionVOS = shopService.getOptionList(productVO.getIdx());
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		
		return "admin/shop/option2";
	}
	
	// 옵션 등록창에서, 상품을 선택하면 선택된 상품의 상세설명을 가져와서 뿌리기
	@ResponseBody
	@RequestMapping(value="/getProductInfor", method = RequestMethod.POST)
	public ProductVO getProductInforPost(String productName) {
		return shopService.getProductInfor(productName);
	}
	
	// 옵션등록창에서 '옵션보기'버튼클릭시에 해당 제품의 모든 옵션을 보여주기
	@ResponseBody
	@RequestMapping(value="/getOptionList", method = RequestMethod.POST)
	public List<OptionVO> getOptionListPost(int productIdx) {
		return shopService.getOptionList(productIdx);
	}
	
	// 옵션 기록사항들을 등록하기
	@RequestMapping(value="/option", method=RequestMethod.POST)
	public String optionPost(Model model, OptionVO vo, String[] optionName, int[] optionPrice,
			@RequestParam(name="flag", defaultValue = "", required=false) String flag) {
		for(int i=0; i<optionName.length; i++) {
			
			int optionCnt = shopService.getOptionSame(vo.getProductIdx(), optionName[i]);
			if(optionCnt != 0) continue;
			
			// 동일한 옵션이 없으면 vo에 set시킨후 옵션테이블에 등록시킨다.
			vo.setProductIdx(vo.getProductIdx());
			vo.setOptionName(optionName[i]);
			vo.setOptionPrice(optionPrice[i]);
			
			shopService.setOptionInput(vo);
		}
		if(!flag.equals("option2")) return "redirect:/message/optionInputOk";
		else {
			model.addAttribute("temp", vo.getProductName());
			return "redirect:/message/optionInput2Ok";
		}
	}
	
	// 옵션 등록창에서 옵션리스트를 확인후 필요없는 옵션항목을 삭제처리..
	@ResponseBody
	@RequestMapping(value="/optionDelete", method = RequestMethod.POST)
	public String optionDeletePost(int idx) {
		shopService.setOptionDelete(idx);
		return "";
	}
	
	// 주문관리.......
	
	
	
	
	
	// ---------------------------------------------------------------------------
	
	/* 사용자에서 처리부분 */
	
	// 등록된 상품 보여주기(사용자(고객)화면에서 보여주기)
	@RequestMapping(value="/productList", method = RequestMethod.GET)
	public String productListGet(Model model,
			@RequestParam(name="part", defaultValue="전체", required=false) String part) {
		List<ProductVO> productTitleVOS = shopService.getProductTitle();
		model.addAttribute("productTitleVOS", productTitleVOS);
		model.addAttribute("part", part);
		
		List<ProductVO> productVOS = shopService.getShopList(part);
		model.addAttribute("productVOS", productVOS);
		return "shop/productList";
	}
	
  // 진열된 상품클릭시 해당상품의 상세정보 보여주기(사용자(고객)화면에서 보여주기)
	@RequestMapping(value="/productContent", method=RequestMethod.GET)
	public String productContentGet(int idx, Model model) {
		ProductVO productVO = shopService.getShopProduct(idx);			// 상품의 상세정보 불러오기
		List<OptionVO> optionVOS = shopService.getShopOption(idx);	// 옵션의 모든 정보 불러오기
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		
		return "shop/productContent";
	}
	
	// 상품상세정보보기창에서 '장바구니'버튼, '주문하기'버튼을 클릭하면 모두 이곳을 거쳐서 이동처리했다.
	// '장바구니'버튼에서는 '다시쇼핑하기'처리했고, '주문하기'버튼에서는 '주문창(장바구니창)'으로 보내도록 처리했다.
	@RequestMapping(value="/productContent", method=RequestMethod.POST)
	public String productContentPost(CartVO vo, HttpSession session, String flag) {
		// CartVO(vo) : 사용자가 선택한 품목(기본품목+옵션)의 정보를 담고 있는 VO
		// CartVO(resVo) : 사용자가 기존에 장바구니에 담아놓은적이 있는 품목(기본품목+옵션)의 정보를 담고 있는 VO
		String mid = (String) session.getAttribute("sMid");
		CartVO resVo = shopService.getCartProductOptionSearch(vo.getProductName(), vo.getOptionName(), mid);
		if(resVo != null) {		// 기존에 구매한적이 있었다면 '현재 구매한 내역'과 '기존 장바구니의 수량'을 합쳐서 'Update'시켜줘야한다.
			String[] voOptionNums = vo.getOptionNum().split(",");
			String[] resOptionNums = resVo.getOptionNum().split(",");
			int[] nums = new int[99];
			String strNums = "";
			for(int i=0; i<voOptionNums.length; i++) {
				nums[i] += (Integer.parseInt(voOptionNums[i]) + Integer.parseInt(resOptionNums[i]));
				strNums += nums[i];
				if(i < nums.length - 1) strNums += ",";
			}
			vo.setOptionNum(strNums);
			shopService.cartUpdate(vo);
		}		// 처음 구매하는 제품이라면 장바구니에 insert시켜준다.
		else {
			shopService.cartInput(vo);
		}
		
		if(flag.equals("order")) {
			return "redirect:/message/cartOrderOk";
		}
		else {
			return "redirect:/message/cartInputOk";
		}
	}
	
	// 장바구니에 담겨있는 모든 상품들의 내역을 보여주기-주문 전단계(장바구니는 DB에 들어있는 자료를 바로 불러와서 처리하면 된다.)
	@RequestMapping(value="/cartList", method=RequestMethod.GET)
	public String cartGet(HttpSession session, CartVO vo, Model model) {
		String mid = (String) session.getAttribute("sMid");
		List<CartVO> vos = shopService.getCartList(mid);
		
		if(vos.size() == 0) {
			return "redirect:/message/cartEmpty";
		}
		
		model.addAttribute("cartListVOS", vos);
		return "shop/cartList";
	}
	
	// 장바구니안에서 삭제시키고자 할 품목을 '구매취소'버튼 눌렀을때 처리
	@ResponseBody
	@RequestMapping(value="/cartDelete", method=RequestMethod.POST)
	public String cartDeleteGet(int idx) {
		shopService.cartDelete(idx);
		return "";
	}
	
	// 장바구니에서 '주문하기'버튼 클릭시에 처리하는 부분
	// 카트에 담겨있는 품목들중에서, 주문한 품목들을 읽어와서 세션에 담아준다. 이때 고객의 정보도 함께 처리하며, 주문번호를 만들어서 다음단계인 '결제'로 넘겨준다.
	@RequestMapping(value = "/cartList", method = RequestMethod.POST)
	public String cartListPost(HttpServletRequest request, Model model, HttpSession session,
			@RequestParam(name="delivery", defaultValue = "0", required = false) int delivery) {
		String mid = session.getAttribute("sMid").toString();
		
		// 주문한 상품에 대하여 '고유번호'를 만들어준다.
		// 고유주문번호(idx) = 기존에 존재하는 주문테이블의 고유번호 + 1
		OrderVO maxIdx = shopService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
				
		// 장바구니에서 구매를 위해 선택한 모든 항목들은 배열로 넘어온다.
		String[] idxChecked = request.getParameterValues("idxChecked");
		
		CartVO cartVO = new CartVO();
		List<OrderVO> orderVOS = new ArrayList<OrderVO>();
		
		for(String strIdx : idxChecked) {
			cartVO = shopService.getCartIdx(Integer.parseInt(strIdx));
			OrderVO orderVO = new OrderVO();
			orderVO.setProductIdx(cartVO.getProductIdx());
			orderVO.setProductName(cartVO.getProductName());
			orderVO.setMainPrice(cartVO.getMainPrice());
			orderVO.setThumbImg(cartVO.getThumbImg());
			orderVO.setOptionName(cartVO.getOptionName());
			orderVO.setOptionPrice(cartVO.getOptionPrice());
			orderVO.setOptionNum(cartVO.getOptionNum());
			orderVO.setTotalPrice(cartVO.getTotalPrice());
			orderVO.setCartIdx(cartVO.getIdx());
			orderVO.setDelivery(delivery);
			
			orderVO.setOrderIdx(orderIdx);	// 관리자가 만들어준 '주문고유번호'를 저장
			orderVO.setMid(mid);						// 로그인한 아이디를 저장한다.
			
			orderVOS.add(orderVO);
		}
		session.setAttribute("sOrderVOS", orderVOS);
		
		// 배송처리를 위한 현재 로그인한 아이디에 해당하는 고객의 정보를 member2테이블에서 가져온다.
		MemberVO memberVO = memberService.getMemberIdCheck(mid);
		model.addAttribute("memberVO", memberVO);
		
		return "shop/order";
	}
	
  // 결제시스템(결제창 호출하기) - API이용
	@RequestMapping(value="/payment", method=RequestMethod.POST)
	public String paymentPost(OrderVO orderVO, PaymentVO paymentVO, DeliveryVO deliveryVO, HttpSession session, Model model) {
		model.addAttribute("paymentVO", paymentVO);
		
		session.setAttribute("sPaymentVO", paymentVO);
		session.setAttribute("sDeliveryVO", deliveryVO);
		
		return "shop/paymentOk";
	}
	
  // 결제(결제창 호출후 결제 완료후에 처리하는 부분)
	// 주문 완료후 주문내역을 '주문테이블(order)에 저장
	// 주문이 완료되었기에 주문된 물품은 장바구니(cartList)에서 내역을 삭제처리한다.
	// 사용한 세션은 제거시킨다.
	// 작업처리후 오늘 구매한 상품들의 정보(구매품목,결제내역,배송지)들을 model에 담아서 확인창으로 넘겨준다.
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/paymentResult", method=RequestMethod.GET)
	public String paymentResultGet(HttpSession session, PaymentVO receivePaymentVO, Model model) {
		// 주문내역 order/delivery 테이블에 저장하기(앞에서 저장했던 세션에서 가져왔다.)
		List<OrderVO> orderVOS = (List<OrderVO>) session.getAttribute("sOrderVOS");
		PaymentVO paymentVO = (PaymentVO) session.getAttribute("sPaymentVO");
		DeliveryVO deliveryVO = (DeliveryVO) session.getAttribute("sDeliveryVO");
		
//		사용된 세션은 반환한다.
//		session.removeAttribute("sOrderVOS");  // 마지막 결제처리후에 결제결과창에서 확인하고 있기에 지우면 안됨
		session.removeAttribute("sDeliveryVO");
		
		for (OrderVO vo : orderVOS) {
//			vo.setProductName(vo.getProductName()); // 상품명
			vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8))); // 주문테이블에 고유번호를 셋팅한다.	
			vo.setOrderIdx(vo.getOrderIdx());        				// 주문번호를 주문테이블의 주문번호필드에 지정처리한다.
			vo.setMid(vo.getMid());							
			
			shopService.setOrder(vo);                 	// 주문내용을 주문테이블(order)에 저장.
			shopService.setCartDeleteAll(vo.getCartIdx()); // 주문이 완료되었기에 장바구니(cart)테이블에서 주문한 내역을 삭체처리한다.
			
		}
		// 주문된 정보를 배송테이블에 담기위한 처리(기존 deliveryVO에 담기지 않은 내역들을 담아주고 있다.)
		deliveryVO.setOIdx(orderVOS.get(0).getIdx());
		deliveryVO.setOrderIdx(orderVOS.get(0).getOrderIdx());
		deliveryVO.setAddress(paymentVO.getBuyer_addr());
		deliveryVO.setTel(paymentVO.getBuyer_tel());
		
		shopService.setDelivery(deliveryVO);  // 배송내용을 배송테이블(delivery)에 저장
		
		paymentVO.setImp_uid(receivePaymentVO.getImp_uid());
		paymentVO.setMerchant_uid(receivePaymentVO.getMerchant_uid());
		paymentVO.setPaid_amount(receivePaymentVO.getPaid_amount());
		paymentVO.setApply_num(receivePaymentVO.getApply_num());
		
		// 오늘 주문에 들어간 정보들을 확인해주기위해 다시 session에 담아서 넘겨주고 있다.
		session.setAttribute("sPaymentVO", paymentVO);
		session.setAttribute("orderTotalPrice", deliveryVO.getOrderTotalPrice());
		
		return "redirect:/message/paymentResultOk";
	}
	
	// 결제완료된 정보 보여주기
	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value="/paymentResultOk", method=RequestMethod.GET)
	public String paymentResultOkGet(HttpSession session, Model model) {
		List<OrderVO> orderVOS = (List<OrderVO>) session.getAttribute("sOrderVOS");
		model.addAttribute("orderVOS", orderVOS);
		session.removeAttribute("sOrderVOS");
		return "shop/paymentResult";
	}
	
	// 배송지 정보 보여주기
	@RequestMapping(value="/orderDelivery", method=RequestMethod.GET)
	public String orderDeliveryGet(String orderIdx, Model model) {
		
		List<DeliveryVO> vos = shopService.getOrderDelivery(orderIdx);  // 같은 주문번호가 2개 이상 있을수 있기에 List객체로 받아온다.
		
		DeliveryVO vo = vos.get(0);  // 같은 배송지면 0번째것 하나만 vo에 담아서 넘겨주면 된다.
		String payMethod = "";
		if(vo.getPayment().substring(0,1).equals("C")) payMethod = "카드결제";
		else payMethod = "은행(무통장)결제";
		
		model.addAttribute("payMethod", payMethod);
		model.addAttribute("vo", vo);
		
		return "shop/orderDelivery";
	}
	
	// 현재 로그인 사용자가 주문내역 조회하기 폼 보여주기
	@RequestMapping(value="/myOrder", method=RequestMethod.GET)
	public String myOrderGet(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");
		if(level == 0) mid = "전체";
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myOrder", mid, "");
		
		// 오늘 구매한 내역을 초기화면에 보여준다.
//		List<ProductVO> vos = shopService.getMyOrderList(pageVO.getStartIndexNo(), pageSize, mid);
		List<DeliveryVO> vos = shopService.getMyOrderList(pageVO.getStartIndexNo(), pageSize, mid);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO",pageVO);
		
		return "shop/myOrder";
	}

  // 주문 조건 조회하기(날짜별(오늘/일주일/보름/한달/3개월/전체)
  @RequestMapping(value="/orderCondition", method=RequestMethod.GET)
  public String orderConditionGet(HttpSession session, int conditionDate, Model model,
      @RequestParam(name="pag", defaultValue="1", required=false) int pag,
      @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
    String mid = (String) session.getAttribute("sMid");
    String strConditionDate = conditionDate + "";
    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "shopMyOrderCondition", mid, strConditionDate);

    List<DeliveryVO> vos = shopService.getOrderCondition(mid, conditionDate, pageVO.getStartIndexNo(), pageSize);
    
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
    model.addAttribute("conditionDate", conditionDate);

    // 아래는 1일/일주일/보름/한달/3달/전체 조회시에 startJumun과 endJumun을 넘겨주는 부분(view에서 시작날짜와 끝날짜를 지정해서 출력시켜주기위해 startJumun과 endJumun값을 구해서 넘겨준다.)
    Calendar startDateJumun = Calendar.getInstance();
    Calendar endDateJumun = Calendar.getInstance();
    startDateJumun.setTime(new Date());  // 오늘날짜로 셋팅
    endDateJumun.setTime(new Date());    // 오늘날짜로 셋팅
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String startJumun = "";
    String endJumun = "";
    switch (conditionDate) {
      case 1:
        startJumun = sdf.format(startDateJumun.getTime());
        endJumun = sdf.format(endDateJumun.getTime());
        break;
      case 7:
        startDateJumun.add(Calendar.DATE, -7);
        break;
      case 15:
        startDateJumun.add(Calendar.DATE, -15);
        break;
      case 30:
        startDateJumun.add(Calendar.MONTH, -1);
        break;
      case 90:
        startDateJumun.add(Calendar.MONTH, -3);
        break;
      case 99999:
        startDateJumun.set(2022, 00, 01);
        break;
      default:
        startJumun = null;
        endJumun = null;
    }
    if(conditionDate != 1 && endJumun != null) {
      startJumun = sdf.format(startDateJumun.getTime());
      endJumun = sdf.format(endDateJumun.getTime());
    }

    model.addAttribute("startJumun", startJumun);
    model.addAttribute("endJumun", endJumun);

    return "shop/myOrder";
  }
	
	// 날짜별 상태별 기존제품 구매한 주문내역 확인하기
	@RequestMapping(value="/myOrderStatus", method=RequestMethod.GET)
	public String myOrderStatusGet(
			HttpServletRequest request, 
			HttpSession session, 
			String startJumun, 
			String endJumun, 
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
  	  @RequestParam(name="conditionOrderStatus", defaultValue="전체", required=false) String conditionOrderStatus,
			Model model) {
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");
		
		if(level == 0) mid = "전체";
		String searchString = startJumun + "@" + endJumun + "@" + conditionOrderStatus;
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myOrderStatus", mid, searchString);  // 4번째인자에 '아이디/조건'(을)를 넘겨서 part를 아이디로 검색처리하게 한다.
		
		List<DeliveryVO> vos = shopService.getMyOrderStatus(pageVO.getStartIndexNo(), pageSize, mid, startJumun, endJumun, conditionOrderStatus);
		model.addAttribute("vos", vos);				
		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);
		model.addAttribute("conditionOrderStatus", conditionOrderStatus);
		model.addAttribute("pageVO", pageVO);
		
		return "shop/myOrder";
	}
	
	// 관리자 상품등록시 메인 이미지만 따로 관리하기(등록된 메인 이미지만 보여주는 화면)
	@RequestMapping(value = "/mainImageList", method = RequestMethod.GET)
	public String mainImageListGet(Model model,
			@RequestParam(name="productCode",defaultValue = "", required = false) String productCode) {
		List<MainImageVO> mainImageVOS = shopService.getMainImageSearch(productCode);
		model.addAttribute("mainImageVOS", mainImageVOS);
		
		List<MainImageVO> vos = shopService.getMainImageList();
		model.addAttribute("vos", vos);
		
		model.addAttribute("productCode", productCode);
		model.addAttribute("productName", mainImageVOS.get(0).getProductName());
		return "admin/shop/mainImageList";
	}
	
	// 관리자 상품등록시 메인 이미지만 별도로 등록하기폼 호출
	@RequestMapping(value = "/mainImageInput", method = RequestMethod.GET)
	public String mainImageInputGet(Model model) {
		List<ProductVO> ArtistVOS = shopService.getCategoryArtist(); // 중분류리스트
		List<ProductVO> ProductVOS = shopService.getCategoryProduct(); // 소분류리스트
	
		model.addAttribute("ArtistVOS", ArtistVOS);
		model.addAttribute("ProductVOS", ProductVOS);
		
		return "admin/shop/mainImageInput";
	}
	
	// 메인 상품 메인이미지 저장처리
	@RequestMapping(value="/mainImageInput", method = RequestMethod.POST)
	public String mainImagePost(MainImageVO vo, MultipartHttpServletRequest fName) {
		int res = shopService.mainImageInput(vo, fName);
		
		if(res == 1) return "redirect:/message/mainImageInputOk";
		else return "redirect:/message/mainImageInputNo";
	}
	
	// 메인 상품 메인이미지 삭제처리
	@RequestMapping(value="/mainImageDelete", method = RequestMethod.GET)
	public String mainImageGet(String productCode) {
		int res = shopService.mainImageDelete(productCode);
		
		if(res == 1) return "1";
		else return "0";
	}
	
	// 상품 삭제
 	@RequestMapping(value = "/productDelete", method = RequestMethod.GET)
 	public String playListDeleteGet(HttpSession session, HttpServletRequest request,
 			@RequestParam(name = "idx", defaultValue = "0", required = false) int idx
 			) {
 		
 		int res = shopService.setProductDelete(idx);
 		
 		if(res == 1) return "redirect:/message/productDeleteOk";
 		else return "redirect:/message/productDeleteNo?idx="+idx;
 	}
	
}
