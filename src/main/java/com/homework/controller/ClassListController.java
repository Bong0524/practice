package com.homework.controller;

import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.homework.vo.ClassInfo;

public class ClassListController implements Controller {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String url = request.getParameter("url");
		HomeworkService service = HomeworkService.getInstance();
		ArrayList<ClassInfo> classList = service.classList();
		request.setAttribute("classList", classList);
		HTTPUtil.forward(request, response, url+".jsp");
	}
}
