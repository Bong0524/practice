package com.homework.controller;

import java.util.ArrayList;

import com.homework.vo.ClassInfo;
import com.homework.vo.HomeworkInfo;
import com.homework.vo.QuestInfo;
import com.homework.vo.SubmitInfo;
import com.homework.vo.SubmitQInfo;
import com.homework.vo.UserInfo;

public class HomeworkService {
	private static HomeworkService service = new HomeworkService();
	
	public HomeworkDAO dao = HomeworkDAO.getInstance();
	public static HomeworkService getInstance() {
		return service;
	}
	
	public ArrayList<HomeworkInfo> homeworkList(String subject) {
		return dao.HomeworkList(subject);
	}
	public ArrayList<HomeworkInfo> homeworkList(String grade,String clas, String subject) {
		return dao.HomeworkList(grade,clas,subject);
	}
	public HomeworkInfo homework(String homeworkId) {
		return dao.Homework(homeworkId);
	}
	public ArrayList<QuestInfo> questList(String homeworkId) {
		return dao.QuestList(homeworkId);
	}
	public void homeworkSubmitQ(String homeworkId, QuestInfo quest, String answer, UserInfo user) {
		dao.HomeworkSubmitQ(homeworkId,quest,answer,user);
	}

	public UserInfo user(String id) {
		return dao.User(id);
	}

	public ArrayList<ClassInfo> classList() {
		return dao.ClassList();
	}

	public String resolved(String homeworkId, UserInfo user) {
		return dao.Resolved(homeworkId, user);
	}

	public ArrayList<SubmitQInfo> submitQList(String homeworkId, UserInfo user) {
		return dao.SubmitQList(homeworkId, user);
	}

	public void homeworkSubmit(String homeworkId, UserInfo user) {
		dao.HomeworkSubmit(homeworkId, user);
	}

	public SubmitInfo submission(String homeworkId, UserInfo user) {
		return dao.Submission(homeworkId, user);
	}

	public ArrayList<SubmitInfo> submitList(HomeworkInfo homework) {
		return dao.SubmitList(homework);
	}

	public ArrayList<SubmitQInfo> submitQList(String homeworkId, String studentId) {
		return dao.SubmitQList(homeworkId, studentId);
	}

	public SubmitInfo submission(String homeworkId, String studentId) {
		return dao.Submission(homeworkId, studentId);
	}

	public void confirmCorrect(String[] correctList, String homeworkId, String studentId) {
		dao.ConfirmCorrect(correctList, homeworkId, studentId);
	}

	public void confirmExplan(String[] explanList, String homeworkId, String studentId) {
		dao.ConfirmExplan(explanList, homeworkId, studentId);
	}

	public void confirm(String homeworkId, String studentId) {
		dao.Confirm(homeworkId, studentId);
	}

	public ArrayList<UserInfo> studentList(UserInfo user) {
		return dao.StudentList(user);
	}

	public void makeQuest(ArrayList<QuestInfo> questList, HomeworkInfo homework) {
		dao.MakeQuest(questList, homework);
	}

	public String overlapId(String id) {
		return dao.OverlapId(id);
	}


}
