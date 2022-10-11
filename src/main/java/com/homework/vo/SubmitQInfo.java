package com.homework.vo;

public class SubmitQInfo {
	private String homeworkId; 
	private String questNum; 
	private String answer; 
	private String id; 
	private String explan;
	private String correct;
	public String getCorrect() {
		return correct;
	}
	public void setCorrect(String correct) {
		this.correct = correct;
	}
	public String getHomeworkId() {
		return homeworkId;
	}
	public void setHomeworkId(String homeworkId) {
		this.homeworkId = homeworkId;
	}
	public String getQuestNum() {
		return questNum;
	}
	public void setQuestNum(String questNum) {
		this.questNum = questNum;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getExplan() {
		return explan;
	}
	public void setExplan(String explan) {
		this.explan = explan;
	}
}
