package com.homework.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserResisterController implements Controller {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String grade = request.getParameter("grade");
		String clas = request.getParameter("clas");
		String num = request.getParameter("num");
		String parent1 = request.getParameter("parent1");
		String parent2 = request.getParameter("parent1");
		String parent3 = request.getParameter("parent1");
		String parent = parent1 + "-" + parent2 + "-" + parent3;
		String how = request.getParameter("how");
		
		HomeworkService service = HomeworkService.getInstance();
		System.out.println(id+","+how);
		if(how.equals("overlap")) {
			String overlap = service.overlapId(id);
			System.out.println(overlap);
			HTTPUtil.printOut(response, overlap);
		}else if(how.equals("studentReg")) {
			
			HTTPUtil.forward(request, response, "login.jsp");
		}else if(how.equals("teacherReg")) {
			
			HTTPUtil.forward(request, response, "login.jsp");
		}
	}

}
