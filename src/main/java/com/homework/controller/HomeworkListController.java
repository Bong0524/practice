package com.homework.controller;

import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.homework.vo.HomeworkInfo;
import com.homework.vo.UserInfo;

public class HomeworkListController implements Controller {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String grade = request.getParameter("grade");
		String clas = request.getParameter("clas");
		String subject = request.getParameter("subject");
		String filter = request.getParameter("filter");
		HttpSession session = request.getSession();
		UserInfo user = (UserInfo)session.getAttribute("user");
		String path = null;
		HomeworkService service = HomeworkService.getInstance();
		ArrayList<HomeworkInfo> homeworkList = null;
		if(filter.equals("All")) {
			path = "/homeworkListAll.jsp";
			homeworkList = service.homeworkList(subject);
		}else if(filter.equals("Clas")) {
			path = "/homeworkListClas.jsp";
			homeworkList = service.homeworkList(grade,clas,subject);
		}
		if(user != null && user.getPosition().equals("선생")) 
			path = "/homeworkListTeacher.jsp";
		
		request.setAttribute("homeworkList", homeworkList);
		request.setAttribute("filter", filter);
		request.setAttribute("grade", grade);
		request.setAttribute("clas", clas);
		
		request.setAttribute("subject", subject);
		HTTPUtil.forward(request, response, path);
	}
}
