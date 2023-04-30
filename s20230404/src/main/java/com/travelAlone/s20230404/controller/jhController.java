package com.travelAlone.s20230404.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.travelAlone.s20230404.config.km.LoginUser;
import com.travelAlone.s20230404.domain.km.MemberJpa;
import com.travelAlone.s20230404.model.Board;
import com.travelAlone.s20230404.model.BodImg;
import com.travelAlone.s20230404.model.Warning;
import com.travelAlone.s20230404.model.dto.ro.BoardWriteRequestDto;
import com.travelAlone.s20230404.service.jh.jhService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class jhController {
	
	private final jhService		js;
	
	// 추천 버튼
	@RequestMapping(value = "/boardlike")
	public String like(Board board, Model model, HttpServletRequest request, HttpServletResponse response) {

	    log.info("jhController boardlike start");
	    int updateCount = 0;
	    String cookieKey = "boardlike" + board.getBoard_id();
	    String result = "";

	    // 쿠키에서 해당 게시물이 추천된 적이 있는지 검사합니다.
	    Cookie[] cookies = request.getCookies();
	    boolean boardLikeChk = false;
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals(cookieKey)) {
	                // 이미 추천한 경우, 처리할 내용을 작성합니다.
	                model.addAttribute("board_id", board.getBoard_id());
	                model.addAttribute("b_common_board", board.getB_common_board());
	                String message = "이미 추천한 게시물입니다.";
	                model.addAttribute("message", message);
	                result = "forward:/detailBoard";
	                boardLikeChk = true;
	                break;
	            }
	        }
	    }

	    // 이미 추천한 경우는 추천수를 증가시키지 않습니다.
	    if (!boardLikeChk) {
	        updateCount = js.updateCount(board);
	        log.info("jhController like result ->" + updateCount);
	        log.info("jhController like board_id ->" + board.getBoard_id());
	        model.addAttribute("updateCount", updateCount);
	        model.addAttribute("board_id", board.getBoard_id());
	        model.addAttribute("b_common_board", board.getB_common_board());
	        result = "forward:/detailBoard";

	        // 쿠키에 해당 게시물이 추천된 것을 기록합니다.
	        Cookie cookie = new Cookie(cookieKey, "true");
	        cookie.setMaxAge(60 * 60 * 24 * 30); // 쿠키 유효기간 30일로 설정
	        response.addCookie(cookie);
	    }

	    return result;
	}
 
	
	// 게시글 신고 버튼
	@RequestMapping(value = "reportMember")
	public String reportMember(Warning warning,Board board,Model model) {
		
		log.info("jhController reportMember start");
		String resultForm = "";
		
		int reportMemberCnt = js.reportMember(warning);
		
		log.info("jhController reportMember reportMemberCnt -> " + reportMemberCnt);
		log.info("jhController reportMember member_id -> " + warning.getMember_id());	// 회원 ID
		log.info("jhController reportMember u_nickname -> " + warning.getU_nickname());	// 신고자 ID
		model.addAttribute("reportMemberCnt", reportMemberCnt);
		model.addAttribute("board_id", board.getBoard_id());
	    model.addAttribute("b_common_board", board.getB_common_board());
	    resultForm = "forward:/detailBoard";
		
	    return resultForm;
	}
	
	// 게시물 작성
	@PostMapping(value = "writeBoard")
	@ResponseBody
	public String writeBoard(@RequestPart(value = "key") BoardWriteRequestDto requestDto,
							 @RequestPart(value = "file", required = false) List<MultipartFile> files,
							 @LoginUser MemberJpa memberJpa,
							 Model model) throws Exception {
		log.info("roController writeBoard start");

		if (memberJpa == null){
			throw new Exception("로그인 해주세요!");
		}
		requestDto.addMemberId(memberJpa.getId());
		int insertResult = js.insertBoard(requestDto,files);
		log.info("roController writeBoard insertResult는 "+ insertResult);
		return ""+insertResult;
	}
	
	// 대댓글 작성
	@RequestMapping(value = "WriteBoardReLevel")
	public String WriteBoardReLevel(Board board, Model model) {
		log.info("jhController WriteBoardReLevel start");
		int insertReLevel = js.insertReLevel(board);
		
		log.info("jhController WriteBoardReLevel insertReLevel -> " + insertReLevel);
	 	model.addAttribute("insertReLevel", insertReLevel);
	 	model.addAttribute("board_id", board.getBoard_id());
	    model.addAttribute("b_common_board", board.getB_common_board());
		return "forward:/detailBoard";
	}
	
	
}