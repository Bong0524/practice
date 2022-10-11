package com.homework.controller;

import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.homework.vo.HomeworkInfo;
import com.homework.vo.QuestInfo;
import com.homework.vo.SubmitInfo;
import com.homework.vo.SubmitQInfo;
import com.homework.vo.UserInfo;

public class HomeworkTeacherController implements Controller {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String[] correctList = request.getParameterValues("correctList");
		String[] explanList = request.getParameterValues("explanList");
		String homeworkId = request.getParameter("homeworkId");
		String studentId = request.getParameter("studentId");
		HttpSession session = request.getSession();
		UserInfo user = (UserInfo) session.getAttribute("user");
		HomeworkService service = HomeworkService.getInstance();
		HomeworkInfo homework = service.homework(homeworkId);  
		ArrayList<QuestInfo> questList = null;
		ArrayList<SubmitInfo> submitList = null;
		ArrayList<SubmitQInfo> submitQList = null;
		SubmitInfo submission = null;
		String path = null;
		
		if(studentId != null) {
			if(correctList != null) {
				path = "/index.jsp";
				service.confirmCorrect(correctList, homeworkId, studentId);
				service.confirmExplan(explanList, homeworkId, studentId);
				service.confirm(homeworkId, studentId);
				request.setAttribute("homeworkId", homeworkId);	
			}else {
				path = "homeworkConfirm.jsp";
				submitQList = service.submitQList(homeworkId, studentId);
				submission = service.submission(homeworkId, studentId);
				questList = service.questList(homeworkId);
				request.setAttribute("submitQList", submitQList);
				request.setAttribute("submission", submission);
				request.setAttribute("questList", questList);
			}
		}else if(user.getGrade().equals(homework.getGrade()) && user.getClas().equals(homework.getClas())){
			path = "homeworkOpenSubmitList.jsp";
			submitList = service.submitList(homework);
			request.setAttribute("submitList", submitList);
		}else {
			 path = "/homeworkOpen.jsp";
			 request.setAttribute("questList", questList);
		}
		request.setAttribute("homework", homework);
		HTTPUtil.forward(request, response, path);
	}
}
