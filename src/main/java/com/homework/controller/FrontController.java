package com.homework.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String charset;
	HashMap<String, Controller> hash = null;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		charset = config.getInitParameter("charset");
		hash = new HashMap<>();
		hash.put("/classList.do", new ClassListController());
		hash.put("/homeworkList.do", new HomeworkListController());
		hash.put("/homeworkOpen.do", new HomeworkOpenController());
		hash.put("/homeworkSubmit.do", new HomeworkSubmitController());
		hash.put("/user.do", new UserController());
		hash.put("/userTeacher.do", new UserTeacherController());
		hash.put("/homeworkTeacher.do", new HomeworkTeacherController());
		hash.put("/homeworkMake.do", new HomeworkMakeController());
		hash.put("/register.do", new UserResisterController());
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding(charset);
		String uri = req.getRequestURI();
		String contextPath = req.getContextPath();
		String path = uri.substring(contextPath.length());
		
		Controller subController = hash.get(path);
		subController.execute(req, resp);
	}
}
