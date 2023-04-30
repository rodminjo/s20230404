package com.travelAlone.s20230404.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Board {

	private long board_id;
	private long member_id;
	private String b_title;
	private String b_content;
	private int b_view_cnt;
	private int b_like_cnt;
	private String b_common_board;
	private int b_ref;
	private int b_re_step;
	private int b_re_level;
	private LocalDateTime create_date;
	private LocalDateTime modified_date;

	// 조인용
	private String m_nickname;

	// 조회용
	private String orderList;
	private int start;
	private int end;
	private String pageNum;
	private int mcd;
	
	//	사진 파일 이름 가져오기
	private List<String> img_stored_file = new ArrayList<>();
	
	// 파일 유무 확인
	private int img_stored_file_yn;
	
	// create_date 날짜 형식 변경
	public String getFormattedCreateDate() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		return create_date.format(formatter);
	}
	
	//전체 검색 결과 페이지용 create_date 날짜 형식 변경
	public String getFormattedCreateDate_search() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		return create_date.format(formatter);
		  }
	
	// 이미지 업로드용
	public Board(long member_id, String b_title, String b_content, String b_common_board) {
		this.member_id = member_id;
		this.b_title = b_title;
		this.b_content = b_content;
		this.b_common_board = b_common_board;
	}

}