package com.demo_board.model.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.demo_board.model.domain.Board;
import com.demo_board.model.domain.BoardRepository;
import com.demo_board.model.domain.ImgFile;
import com.demo_board.model.domain.ImgFileRepository;
import com.demo_board.model.domain.Like;
import com.demo_board.model.domain.LikePK;
import com.demo_board.model.domain.LikeRepository;
import com.demo_board.model.domain.Member;
import com.demo_board.model.domain.Reply;
import com.demo_board.model.domain.ReplyRepository;
import com.demo_board.model.service.BoardService;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

@Controller
public class BoardController {
	
	@Autowired
	private BoardRepository boardRepository;
	@Autowired
	private ImgFileRepository imgFileRepository;
	@Autowired
	private ReplyRepository replyRepository;
	@Autowired
	private LikeRepository likeRepository;
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/write")
	public String writeForm(){
		return "/board/write-form";
	}
	
	@PostMapping("/modify")
	public ModelAndView updateForm(Board board, ModelAndView mv){
		Optional<Board> b = boardRepository.findById(board.getBoardNo());
		mv.addObject("board", b.get());
		mv.setViewName("/board/update-form");
		return mv;
	}
	
	@PostMapping("/update")
	public ModelAndView updateBoard(Board board, ModelAndView mv) {
		Optional<Board> b = boardRepository.findById(board.getBoardNo());
		b.ifPresent(updateB ->{
			updateB.setBoardTitle(board.getBoardTitle());
			updateB.setBoardContent(board.getBoardContent());
			Board updatedBoard = boardRepository.save(updateB);
			mv.addObject("board", updatedBoard);
		});
		mv.setViewName("/board/update-process");
		return mv;
	}
	
	@PostMapping("/remove")
	public void removeBoard(Board board, HttpServletResponse response) {
		Optional<Board> b = boardRepository.findById(board.getBoardNo());
		b.ifPresent(updateB ->{
			updateB.setBoardStatus("N");
			Board removedBoard = boardRepository.save(updateB);
			if(removedBoard != null) {
				try {
					response.sendRedirect("/");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}else {
				PrintWriter out;
				try {
					out = response.getWriter();
					out.print("<script>");
					out.print("alertify.alert('Remove failed');");
					out.print("javascript:history.go(-1);");
					out.print("</script>");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		});
	}
	
	@PostMapping("/insert")
	public void insertBoard(Board board, ModelAndView mv, HttpServletResponse response) {
		try {
			boardRepository.save(board);
			response.sendRedirect("/");
		} catch (IOException e) {
			e.printStackTrace();
		};
	}
	
	@PostMapping("/getReplyList")
	public void getReplyList(Board board, HttpServletResponse response) throws JsonIOException, IOException {
		List<Reply> replyList = replyRepository.findByBoardNo(board.getBoardNo());
		response.setContentType("application/json; charset=utf-8");
		Gson gson = new Gson();
		gson.toJson(replyList, response.getWriter());
	}
	
	@ResponseBody
	@PostMapping("/addReply")
	public String addReply(Reply reply) {
		Reply r = replyRepository.save(reply);
		if(r != null) {
			Optional<Board> b = boardRepository.findById(reply.getBoardNo());
			b.ifPresent(countPlusB ->{
				countPlusB.setBoardReply(b.get().getBoardReply()+1);
				boardRepository.save(countPlusB);
			});
			return "success";
		}
		else return "fail";
	}
	
	@PostMapping("/view")
	public ModelAndView veiwDetail(HttpSession session, ModelAndView mv, Board board) {
		Member user = (Member)session.getAttribute("loginUser");
		Optional<Board> b = boardRepository.findById(board.getBoardNo());
		b.ifPresent(countPlusB ->{
			countPlusB.setBoardViewCnt(b.get().getBoardViewCnt()+1);
			Board updatedBoard = boardRepository.save(countPlusB);
			mv.addObject("board", updatedBoard);
			Optional<Like> like = likeRepository.findById(new LikePK(board.getBoardNo(), user.getId()));
			if(like.isPresent()) {
				mv.addObject("isLike", true);
			} else {
				mv.addObject("isLike", false);
			}
		});
		mv.setViewName("/board/board-view-form");
		return mv;
	}
	
	@GetMapping("/paging")
	public ModelAndView boardsPaging(int pageNum, ModelAndView mv, String condition1, String condition2) {
		if(condition1 != "") {
			mv = boardService.searchBoards(pageNum-1, condition1, condition2, mv);
		} else {
			mv = boardService.boardPaging(pageNum-1, mv);
		}
		mv.setViewName("index");
		return mv;
	}
	
	@ResponseBody
	@PostMapping("/modifyReply")
	public String modifyReply(Reply reply) {
		Optional<Reply> r = replyRepository.findById(reply.getReplyNo());
		if(r.isPresent()) {
			Reply updateR = r.get();
			updateR.setReplyContent(reply.getReplyContent());
			Reply updatedReply = replyRepository.save(updateR);
			if(updatedReply != null) {
				return "success";
			} else {
				return "fail";
			}
		} else {
			return "fail";
		}
	}
	
	@ResponseBody
	@PostMapping("/likeCount")
	public Long likeCount(Long bNo, Long count, LikePK likePk, boolean plus) {
		Optional<Board> b = boardRepository.findById(bNo);
		b.ifPresent(countPlusB ->{
			countPlusB.setBoardLike(count);
			boardRepository.save(countPlusB);
		});
		if(plus == true) {	// 좋아요+1 일때
			likeRepository.save(new Like(likePk));
		} else {			// 좋아요-1 일때
			likeRepository.deleteById(likePk);
		}
		return count;
	}
	
	@PostMapping("/upload")
	public void imgFileUpload(MultipartHttpServletRequest multiRequest, HttpServletResponse response,
			HttpServletRequest request, MultipartFile uploadFile) {
		// test
		System.out.println("업로드 들어옴");
		
		try {
			String callback = multiRequest.getParameter("callback");
			String callback_func = "?callback_func="+multiRequest.getParameter("callback_func");
			String return_url = "";
			
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			
			String fileName = "";
			
			// 파일이 저장될 경로 설정
			String root = request.getSession().getServletContext().getRealPath("jsp");
			String savePath = root + "\\upload";
			
			fileName = saveFile(uploadFile, request);
			
			ImgFile imgFile = new ImgFile();
			imgFile.setImgPath(savePath);
			imgFile.setOriginImgName(uploadFile.getOriginalFilename());
			imgFile.setChangeImgName(fileName);
			
			// test
			System.out.println(imgFile);
			
			imgFileRepository.save(imgFile);			
			
			return_url += "&bNewLine=true";
			return_url += "&sFileName="+fileName;
//			return_url += "&sFileURL=/upload/"+date+"/"+changeName+"."+fileExt;
			
			response.sendRedirect(callback+callback_func+return_url);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}
	
	public String saveFile(MultipartFile file, HttpServletRequest request) {
		// 파일이 저장될 경로 설정
		String root = request.getSession().getServletContext().getRealPath("jsp");
		String savePath = root + "\\upload";
		
		File folder = new File(savePath);	// 저장될 폴더
		
		if(!folder.exists()) {	// 폴더가 없다면
			folder.mkdirs();	// 폴더를 생성해라
		}
		
		String originalFileName = file.getOriginalFilename();	// 원본명(확장자)
		
		// 파일명 수정작업 --> 년월일시분초.확장자
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String random = String.valueOf((int)(Math.random()*100)+1);
		
		String changeFileName = sdf.format(new Date(System.currentTimeMillis())) // 년월일시분초
							  + random + originalFileName.substring(originalFileName.lastIndexOf("."));
		
		// 실제 저장될 경로 savePath + 저장하고자하는 파일명 renameFileName
		String renamePath = savePath + "\\" + changeFileName;	
		
		try {
			file.transferTo(new File(renamePath));
			
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return changeFileName;	// 수정명 반환
	}
}
