package com.homework.controller;

import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.homework.vo.QuestInfo;
import com.homework.vo.UserInfo;

public class HomeworkSubmitController implements Controller {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		HttpSession session = request.getSession();
		UserInfo user = (UserInfo)session.getAttribute("user");
		String homeworkId = request.getParameter("homeworkId");
		HomeworkService service = HomeworkService.getInstance();
		ArrayList<QuestInfo> questList = service.questList(homeworkId);
		
		service.homeworkSubmit(homeworkId,user);
		
		String answer = null;
		for(int i = 0 ; i < questList.size() ; i++) {
			if(questList.get(i).getKind().equals("four")) answer = String.join("", request.getParameterValues(""+i));
			else answer = request.getParameter(""+i);
			service.homeworkSubmitQ(homeworkId,questList.get(i),answer,user);
		}
		HTTPUtil.redirect(response, "/homework");
	}
}
