package com.homework.controller;

import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.homework.vo.UserInfo;

public class UserTeacherController implements Controller {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		HttpSession session = request.getSession();
		UserInfo user = (UserInfo) session.getAttribute("user");
		
		HomeworkService service = HomeworkService.getInstance();
		
		ArrayList<UserInfo> studentList = service.studentList(user);
		request.setAttribute("studentList", studentList);
		request.setAttribute("user", user);
		HTTPUtil.forward(request, response, "studentList.jsp");
	}
}
