package com.homework.controller;

import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.homework.vo.HomeworkInfo;
import com.homework.vo.QuestInfo;
import com.homework.vo.UserInfo;

public class HomeworkMakeController implements Controller {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		HomeworkService service = HomeworkService.getInstance();
		ArrayList<QuestInfo> questList = new ArrayList<QuestInfo>();
		String[] questText = request.getParameterValues("questText");
		String[] kind = request.getParameterValues("kind");
		HttpSession session = request.getSession();
		UserInfo user = (UserInfo)session.getAttribute("user");
		HomeworkInfo homework = new HomeworkInfo();
		String title = request.getParameter("title");
		String subject = request.getParameter("subject");
		String enDate = request.getParameter("enDate");
		homework.setTitle(title);
		homework.setSubject(subject);
		homework.setEnDate(enDate);
		homework.setGrade(user.getGrade());
		homework.setClas(user.getClas());
		for(int i = 0 ; i < kind.length ; i++) {
			QuestInfo quest = new QuestInfo();
			quest.setQuestNum((i+1)+"");
			quest.setKind(kind[i]);
			quest.setQuest(questText[i]);
			if(kind[i].equals("four")) quest.setAnswer(String.join("", request.getParameterValues(""+(i+1))));
			else quest.setAnswer(request.getParameter(i+1+""));
			if(kind[i].equals("five") || kind[i].equals("four")) {
				String[] selectText= request.getParameterValues("selectText"+(i+1));
				quest.setFirst(selectText[0]);
				quest.setSecond(selectText[1]);
				quest.setThird(selectText[2]);
				quest.setFourth(selectText[3]);
				quest.setFifth(selectText[4]);
			}
			questList.add(quest);
		}
		service.makeQuest(questList, homework);
		HTTPUtil.redirect(response, "index.jsp");
	}

}
