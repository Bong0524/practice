package com.homework.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.homework.vo.UserInfo;

public class UserController implements Controller {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		HomeworkService service = HomeworkService.getInstance();
		HttpSession session = request.getSession();
		String path = null;
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		UserInfo user = service.user(id);
		String already = null;
		//비밀번호를 받앗을경우 (로그인 시도시)
		if(id == null) {
			session.invalidate();
			HTTPUtil.redirect(response, "/homework");
		}else if(pw != null) {
			if(user.getPw() != null && user.getPw().equals(pw)){
				session.setAttribute("user", user);
				path ="/index.jsp";
			}else {
				request.setAttribute("warning", "아이디 혹은 비밀번호가 일치하지 않습니다.");
				path ="/login.jsp";
			}
			HTTPUtil.forward(request, response, path);
		//아이디만 받았을경우(아이디 중복 확인시)
		}else {
			if(user != null) already = "1";
			else already = "0";
			HTTPUtil.printOut(response, already);
		}
	}
}
