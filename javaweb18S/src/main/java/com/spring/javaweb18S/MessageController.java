package com.spring.javaweb18S;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String listGet(@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required=false) String mid,
			@RequestParam(name="name", defaultValue = "", required=false) String name,
			@RequestParam(name="temp", defaultValue = "", required=false) String temp,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {

		if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "게시글이 등록되었습니다.");
			model.addAttribute("url", "/guest/guestList");
		}
		else if(msgFlag.equals("guestInputNo")) {
			model.addAttribute("msg", "게시글 등록 실패");
			model.addAttribute("url", "/guest/guestInput");
		}
		else if(msgFlag.equals("guestAdminOk")) {
			model.addAttribute("msg", "관리자 인증 성공");
			model.addAttribute("url", "/guest/guestList");
		}
		else if(msgFlag.equals("guestAdminNo")) {
			model.addAttribute("msg", "관리자 인증 실패");
			model.addAttribute("url", "/guest/adminLogin");
		}
		else if(msgFlag.equals("adminLogout")) {
			model.addAttribute("msg", "관리자 로그아웃");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일 전송 완료");
			model.addAttribute("url", "/study/mail/mailForm");
		}
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("msg", "중복된 아이디가 있습니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("nickNameCheckNo")) {
			model.addAttribute("msg", "중복된 닉네임이 있습니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입 완료");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원가입 실패");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid + "님 로그인 되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인 실패\\n다시 시도해주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid + "님 로그아웃 되었습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자만 사용 가능한 페이지입니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "로그인 후 사용 가능한 페이지입니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("levelCheckNo")) {
			model.addAttribute("msg", "회원등급을 확인하세요.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberIdCheckNo")) {
			model.addAttribute("msg", "존재하지 않는 아이디입니다.");
			model.addAttribute("url", "/member/memberPwdFind");
		}
		else if(msgFlag.equals("memberEmailCheckNo")) {
			model.addAttribute("msg", "존재하지 않는 이메일입니다.");
			model.addAttribute("url", "/member/memberPwdFind");
		}
		else if(msgFlag.equals("memberImsiPwdOk")) {
			model.addAttribute("msg", "임시비밀번호가 발급되었습니다.\\n메일 확인 후 비밀번호를 변경하세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberImsiPwdNo")) {
			model.addAttribute("msg", "임시비밀번호 발급 실패");
			model.addAttribute("url", "/member/memberPwdFind");
		}
		else if(msgFlag.equals("memberPwdUpdateOk")) {
			model.addAttribute("msg", "비밀번호가 변경되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberNameCheckNo")) {
			model.addAttribute("msg", "존재하지 않는 회원입니다.");
			model.addAttribute("url", "/member/memberIdFind");
		}
		else if(msgFlag.equals("memberEmailCheckNo2")) {
			model.addAttribute("msg", "존재하지 않는 이메일입니다.");
			model.addAttribute("url", "/member/memberIdFind");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "파일 업로드 성공");
			model.addAttribute("url", "/study/fileUpload/fileUploadForm");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "파일 업로드 실패");
			model.addAttribute("url", "/study/fileUpload/fileUploadForm");
		}
		else if(msgFlag.equals("memberPwdCheckNo")) {
			model.addAttribute("msg", "회원정보를 확인하세요.");
			model.addAttribute("url", "/member/memberPwdCheck");
		}
		else if(msgFlag.equals("memberNickCheckNo")) {
			model.addAttribute("msg", "닉네임을 확인하세요.");
			model.addAttribute("url", "/member/memberPwdCheck");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원 정보 수정 완료");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg", "회원 정보 수정 실패");
			model.addAttribute("url", "/member/memberUpdate");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시글 등록 완료");
			model.addAttribute("url", "/board/boardList");
		}
		else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("msg", "게시글 등록 실패");
			model.addAttribute("url", "/board/boardInput");
		}
		else if(msgFlag.equals("songInfoInsertOk")) {
			model.addAttribute("msg", "음원 정보 등록 완료");
			model.addAttribute("url", "/song/songInfoUpdate");
		}
		else if(msgFlag.equals("songInfoInsertNo")) {
			model.addAttribute("msg", "음원 정보 등록 실패");
			model.addAttribute("url", "/song/songInfoInsert");
		}
		else if(msgFlag.equals("songInfoUpdateOk")) {
			model.addAttribute("msg", "음원 정보 수정 완료");
			model.addAttribute("url", "/song/songInfoUpdate");
		}
		else if(msgFlag.equals("songInfoUpdateNo")) {
			model.addAttribute("msg", "음원 정보 수정 실패");
			model.addAttribute("url", "/song/songInfoUpdate");
		}
		else if(msgFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg", "게시글 삭제 완료");
			model.addAttribute("url", "/board/boardList");
		}
		else if(msgFlag.equals("boardDeleteNo")) {
			model.addAttribute("msg", "게시글 삭제 실패");
			model.addAttribute("url", "/board/boardContent?idx="+idx+"&pag="+pag+"&pageSize"+pageSize);
		}
		else if(msgFlag.equals("playListDeleteOk")) {
			model.addAttribute("msg", "플레이리스트가 삭제되었습니다.");
			model.addAttribute("url", "/member/playList");
		}
		else if(msgFlag.equals("playListDeleteNo")) {
			model.addAttribute("msg", "플레이리스트 삭제 실패");
			model.addAttribute("url", "/member/playListDetail?idx="+idx);
		}
		else if(msgFlag.equals("productDeleteOk")) {
			model.addAttribute("msg", "상품이 삭제되었습니다.");
			model.addAttribute("url", "/shop/shopList");
		}
		else if(msgFlag.equals("productDeleteNo")) {
			model.addAttribute("msg", "상품 삭제 실패");
			model.addAttribute("url", "/shop/shopContent?idx="+idx);
		}
		else if(msgFlag.equals("boardUpdateOk")) {
			model.addAttribute("msg", "게시글 수정 완료");
			model.addAttribute("url", "/board/boardList?pag="+pag+"&pageSize"+pageSize);
		}
		else if(msgFlag.equals("boardUpdateNo")) {
			model.addAttribute("msg", "게시글 수정 실패");
			model.addAttribute("url", "/board/boardUpdate?idx="+idx+"&pag="+pag+"&pageSize"+pageSize);
		}
		else if(msgFlag.equals("userInputOk")) {
			model.addAttribute("msg", "유저 등록 성공");
			model.addAttribute("url", "/study/validator/validatorList");
		}
		else if(msgFlag.equals("userInputNo")) {
			model.addAttribute("msg", "유저 등록 실패");
			model.addAttribute("url", "/study/validator/validatorForm");
		}
		else if(msgFlag.equals("userCheckNo")) {
			model.addAttribute("msg", "유저 정보를 확인하세요.");
			model.addAttribute("url", "/study/validator/validatorForm");
		}
		else if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("msg", "유저 삭제 완료");
			model.addAttribute("url", "/study/validator/validatorList");
		}
		else if(msgFlag.equals("validatorError")) {
			model.addAttribute("msg", "등록 실패\\n"+temp+"를 확인하세요.");
			model.addAttribute("url", "/study/validator/validatorList");
		}
		else if(msgFlag.equals("memberDeleteOk")) {
			model.addAttribute("msg", "회원 탈퇴 완료되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url", "/shop/shopList");
		}
		else if(msgFlag.equals("optionInputOk")) {
			model.addAttribute("msg", "옵션 항목이 등록되었습니다.");
			model.addAttribute("url", "/shop/option");
		}
		else if(msgFlag.equals("optionInput2Ok")) {
			model.addAttribute("msg", "옵션 항목이 등록되었습니다.");
			model.addAttribute("url", "/shop/option2?productName="+temp);
		}
		else if(msgFlag.equals("thumbnailCreateOk")) {
			model.addAttribute("msg", "썸네일 이미지가 생성되었습니다.");
			model.addAttribute("url", "/study/thumbnail/thumbnailResult");
		}
		else if(msgFlag.equals("thumbnailCreateNo")) {
			model.addAttribute("msg", "썸네일 이미지 생성 실패~~");
			model.addAttribute("url", "/study/thumbnail/thumbnailForm");
		}
		else if(msgFlag.equals("cartOrderOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n주문창으로 이동합니다.");
			model.addAttribute("url", "/shop/cartList");
		}
		else if(msgFlag.equals("cartInputOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n즐거운 쇼핑되세요.");
			model.addAttribute("url", "/shop/productList");
		}
		else if(msgFlag.equals("cartEmpty")) {
			model.addAttribute("msg", "장바구니가 비어있습니다.");
			model.addAttribute("url", "/shop/productList");
		}
		else if(msgFlag.equals("paymentResultOk")) {
			model.addAttribute("msg", "결제가 정상적으로 완료되었습니다.");
			model.addAttribute("url", "/shop/paymentResultOk");
		}
		else if(msgFlag.equals("transactionInput1Ok")) {
			model.addAttribute("msg", "개별 회원 처리가 성공적으로 수행되었습니다.");
			model.addAttribute("url", "/study/transaction/transactionList");
		}
		else if(msgFlag.equals("transactionInput2Ok")) {
			model.addAttribute("msg", "회원 일괄 처리가 성공적으로 수행되었습니다.");
			model.addAttribute("url", "/study/transaction/transactionList");
		}
		else if(msgFlag.equals("mainImageInputOk")) {
			model.addAttribute("msg", "메인이미지가 등록되었습니다.");
			model.addAttribute("url", "/shop/mainImageList");
		}
		else if(msgFlag.equals("mainImageInputNo")) {
			model.addAttribute("msg", "메인이미지 등록 실패~~");
			model.addAttribute("url", "/shop/mainImageInput");
		}

		return "include/message";
	}


}
