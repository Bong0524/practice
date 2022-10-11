package com.homework.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.homework.base.JDBCConnection;
import com.homework.vo.ClassInfo;
import com.homework.vo.HomeworkInfo;
import com.homework.vo.QuestInfo;
import com.homework.vo.SubmitInfo;
import com.homework.vo.SubmitQInfo;
import com.homework.vo.UserInfo;

public class HomeworkDAO {
	private static HomeworkDAO dao = new HomeworkDAO();

	public static HomeworkDAO getInstance() {
		return dao;
	}

	public ArrayList<HomeworkInfo> HomeworkList(String subject) {
		System.out.println("all List, subject : " + subject);
		ArrayList<HomeworkInfo> homeworkList = new ArrayList<HomeworkInfo>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select homeworkId, grade, class, title, subject, stDate, enDate, ceil(enDate - sysdate+1) as timeout from hw_homework ";
			if (subject != null)
				sql += " where subject = " + "'" + subject + "' ";
			sql += " order by (case when timeout > 0 then 1 end), timeout ";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				HomeworkInfo homework = new HomeworkInfo();
				homework.setHomeworkId(rs.getString(1));
				homework.setGrade(rs.getString(2));
				homework.setClas(rs.getString(3));
				homework.setTitle(rs.getString(4));
				homework.setSubject(rs.getString(5));
				homework.setStDate(rs.getString(6));
				homework.setEnDate(rs.getString(7));
				homework.setTimeout(rs.getInt(8));
				homeworkList.add(homework);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return homeworkList;
	}

	public ArrayList<HomeworkInfo> HomeworkList(String grade, String clas, String subject) {
		System.out.println("clas List, grade : " + grade + ", clas : " + clas + ", subject : " + subject);
		ArrayList<HomeworkInfo> homeworkList = new ArrayList<HomeworkInfo>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select homeworkId, grade, class, title, subject, stDate, enDate, ceil(enDate - sysdate+1) as timeout from hw_homework where grade = ? and class = ? ";
			if (subject != null)
				sql += "and subject = " + "'" + subject + "' ";
			sql += " order by (case when timeout > 0 then 1 end), timeout ";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, grade);
			stmt.setString(2, clas);
			rs = stmt.executeQuery();
			while (rs.next()) {
				HomeworkInfo homework = new HomeworkInfo();
				homework.setHomeworkId(rs.getString(1));
				homework.setGrade(rs.getString(2));
				homework.setClas(rs.getString(3));
				homework.setTitle(rs.getString(4));
				homework.setSubject(rs.getString(5));
				homework.setStDate(rs.getString(6));
				homework.setEnDate(rs.getString(7));
				homework.setTimeout(rs.getInt(8));
				homeworkList.add(homework);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return homeworkList;
	}

	public HomeworkInfo Homework(String homeworkId) {
		System.out.println("openHomework : " + homeworkId);
		HomeworkInfo homework = new HomeworkInfo();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = JDBCConnection.getConnection();
			String sql = "select homeworkId, grade, class, title, subject,stDate, enDate, ceil(enDate - sysdate+1) as timeout from hw_homework where homeworkId = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, homeworkId);
			rs = stmt.executeQuery();
			if (rs.next()) {
				homework.setHomeworkId(rs.getString(1));
				homework.setGrade(rs.getString(2));
				homework.setClas(rs.getString(3));
				homework.setTitle(rs.getString(4));
				homework.setSubject(rs.getString(5));
				homework.setStDate(rs.getString(6));
				homework.setEnDate(rs.getString(7));
				homework.setTimeout(rs.getInt(8));
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return homework;
	}

	public ArrayList<QuestInfo> QuestList(String homeworkId) {
		System.out.println("QuestList : " + homeworkId);
		ArrayList<QuestInfo> questList = new ArrayList<QuestInfo>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select * from hw_quest where homeworkId = ? order by questNum";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, homeworkId);
			rs = stmt.executeQuery();
			while (rs.next()) {
				QuestInfo quest = new QuestInfo();
				quest.setHomeworkId(rs.getString(1));
				quest.setQuestNum(rs.getString(2));
				quest.setKind(rs.getString(3));
				quest.setQuest(rs.getString(4));
				quest.setAnswer(rs.getString(5));
				quest.setFirst(rs.getString(6));
				quest.setSecond(rs.getString(7));
				quest.setThird(rs.getString(8));
				quest.setFourth(rs.getString(9));
				quest.setFifth(rs.getString(10));

				questList.add(quest);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return questList;
	}

	public void HomeworkSubmit(String homeworkId, UserInfo user) {
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = JDBCConnection.getConnection();
			String sql = "insert into hw_submit(homeworkId,grade,class,id,name,num) values(?,?,?,?,?,?)";
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, homeworkId);
			stmt.setString(2, user.getGrade());
			stmt.setString(3, user.getClas());
			stmt.setString(4, user.getId());
			stmt.setString(5, user.getName());
			stmt.setString(6, user.getNum());

			int cnt = stmt.executeUpdate();
			System.out.println(cnt);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt);
		}
	}

	public void HomeworkSubmitQ(String homeworkId, QuestInfo quest, String answer, UserInfo user) {
		System.out.println("submit - name : " + user.getName() + " homeworkId : " + homeworkId + " questNum : "
				+ quest.getQuestNum() + " answer : " + answer);
		Connection conn = null;
		PreparedStatement stmt = null;

		String correct = null;
		if (quest.getAnswer() != null) {
			if (quest.getAnswer().equals(answer))
				correct = "1";
			else if (answer != null)
				correct = "0";
		}

		try {
			conn = JDBCConnection.getConnection();
			String sql = "insert into hw_submitQ(homeworkId,questNum,answer,id,correct) values(?,?,?,?,?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, homeworkId);
			stmt.setString(2, quest.getQuestNum());
			stmt.setString(3, answer);
			stmt.setString(4, user.getId());
			stmt.setString(5, correct);

			int cnt = stmt.executeUpdate();
			System.out.println(cnt);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt);
		}
	}

	public UserInfo User(String id) {
		System.out.println("id : " + id);
		UserInfo user = new UserInfo();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = JDBCConnection.getConnection();
			String sql = "select * from hw_user where id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			if (rs.next()) {
				user.setId(rs.getString(1));
				user.setPw(rs.getString(2));
				user.setName(rs.getString(3));
				user.setTel(rs.getString(4));
				user.setParent(rs.getString(5));
				user.setGrade(rs.getString(6));
				user.setClas(rs.getString(7));
				user.setNum(rs.getString(8));
				user.setPosition(rs.getString(9));
				user.setConfirm(rs.getString(10));
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return user;
	}

	public ArrayList<ClassInfo> ClassList() {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<ClassInfo> classList = new ArrayList<>();

		try {
			conn = JDBCConnection.getConnection();
			String sql = "select * from hw_class";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				ClassInfo clas = new ClassInfo();
				clas.setGrade(rs.getString(1));
				clas.setClas(rs.getString(2));
				classList.add(clas);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return classList;
	}

	public String Resolved(String homeworkId, UserInfo user) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String resovled = null;
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select id from hw_submit where homeworkId = ? and id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, homeworkId);
			stmt.setString(2, user != null ? user.getId() : "");
			rs = stmt.executeQuery();
			resovled = rs.next() ? "1" : "0";
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return resovled;
	}

	public ArrayList<SubmitQInfo> SubmitQList(String homeworkId, UserInfo user) {

		ArrayList<SubmitQInfo> submitQList = new ArrayList<SubmitQInfo>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select * from hw_submitQ where homeworkId = ? and id = ? order by questNum";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, homeworkId);
			stmt.setString(2, user != null ? user.getId() : "");
			rs = stmt.executeQuery();
			while (rs.next()) {
				SubmitQInfo submissionQ = new SubmitQInfo();
				submissionQ.setHomeworkId(rs.getString(1));
				submissionQ.setQuestNum(rs.getString(2));
				submissionQ.setAnswer(rs.getString(3));
				submissionQ.setId(rs.getString(4));
				submissionQ.setExplan(rs.getString(5));
				submissionQ.setCorrect(rs.getString(6));
				submitQList.add(submissionQ);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return submitQList;
	}

	public SubmitInfo Submission(String homeworkId, UserInfo user) {
		SubmitInfo submission = new SubmitInfo();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select * from hw_submit where homeworkId = ? and id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, homeworkId);
			stmt.setString(2, user != null ? user.getId() : "");
			rs = stmt.executeQuery();
			while (rs.next()) {

				submission.setHomeworkId(rs.getString(1));
				submission.setId(rs.getString(2));
				submission.setGrade(rs.getString(3));
				submission.setClas(rs.getString(4));
				submission.setName(rs.getString(5));
				submission.setNum(rs.getString(6));
				submission.setFeedback(rs.getString(7));
				submission.setSubDate(rs.getString(8));
				submission.setConfirm(rs.getString(9));
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return submission;
	}

	public ArrayList<SubmitInfo> SubmitList(HomeworkInfo homework) {
		ArrayList<SubmitInfo> submitList = new ArrayList<SubmitInfo>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = JDBCConnection.getConnection();
			String sql =  " select a.id, a.grade, a.class, a.num, a.name, case when a.subDate = b.subDate then a.subDate else null end as subDate, case when a.confirm = b.confirm then 'O' else 'X' end as confirm, a.homeworkId from "
						+ " (select u.*, s.subDate, s.confirm, h.homeworkId from hw_user u cross join hw_homework h left join hw_submit s on h.homeworkId = s.homeworkId) a inner join "
						+ " (select u.*, s.subDate, s.confirm, h.homeworkId from hw_user u cross join hw_homework h left join hw_submit s on u.id = s.id ) b "
						+ " on a.id = b.id and a.homeworkId = b.homeworkId where a.grade = ? and a.class = ? and a.homeworkId = ? and a.position = '학생' order by a.num "+"";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, homework.getGrade());
			stmt.setString(2, homework.getClas());
			stmt.setString(3, homework.getHomeworkId());
			rs = stmt.executeQuery();
			while (rs.next()) {
				SubmitInfo submission = new SubmitInfo();
				submission.setId(rs.getString(1));
				submission.setGrade(rs.getString(2));
				submission.setClas(rs.getString(3));
				submission.setNum(rs.getString(4));
				submission.setName(rs.getString(5));
				submission.setSubDate(rs.getString(6));
				submission.setConfirm(rs.getString(7));
				submission.setHomeworkId(rs.getString(8));
				submitList.add(submission);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return submitList;
	}

	public SubmitInfo Submission(String homeworkId, String studentId) {
		SubmitInfo submission = new SubmitInfo();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select * from hw_submit where homeworkId = ? and id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, homeworkId);
			stmt.setString(2, studentId);
			rs = stmt.executeQuery();
			while (rs.next()) {

				submission.setHomeworkId(rs.getString(1));
				submission.setId(rs.getString(2));
				submission.setGrade(rs.getString(3));
				submission.setClas(rs.getString(4));
				submission.setName(rs.getString(5));
				submission.setNum(rs.getString(6));
				submission.setFeedback(rs.getString(7));
				submission.setSubDate(rs.getString(8));
				submission.setConfirm(rs.getString(9));
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return submission;

	}

	public ArrayList<SubmitQInfo> SubmitQList(String homeworkId, String studentId) {
		ArrayList<SubmitQInfo> submitQList = new ArrayList<SubmitQInfo>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select * from hw_submitQ where homeworkId = ? and id = ? order by questNum";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, homeworkId);
			stmt.setString(2, studentId);
			rs = stmt.executeQuery();
			while (rs.next()) {
				SubmitQInfo submissionQ = new SubmitQInfo();
				submissionQ.setHomeworkId(rs.getString(1));
				submissionQ.setQuestNum(rs.getString(2));
				submissionQ.setAnswer(rs.getString(3));
				submissionQ.setId(rs.getString(4));
				submissionQ.setExplan(rs.getString(5));
				submissionQ.setCorrect(rs.getString(6));
				submitQList.add(submissionQ);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return submitQList;
	}

	public void ConfirmCorrect(String[] correctList, String homeworkId, String studentId) {
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = JDBCConnection.getConnection();
			String sql = "update hw_submitQ set correct = ? where homeworkId = "+homeworkId+" and id = '"+studentId+"' and questNum = ?"; 
			for(int i = 0 ; i < correctList.length ; i++) {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, correctList[i]);
				stmt.setInt(2, (i+1));
				int cnt = stmt.executeUpdate();
				System.out.println(cnt);
				stmt.close();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt);
		}
	}

	public void ConfirmExplan(String[] explanList, String homeworkId, String studentId) {
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = JDBCConnection.getConnection();
			String sql = "update hw_submitQ set explan = ? where homeworkId = "+homeworkId+" and id = '"+studentId+"' and questNum = ?"; 
			for(int i = 0 ; i < explanList.length ; i++) {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, explanList[i]);
				stmt.setInt(2, (i+1));
				int cnt = stmt.executeUpdate();
				System.out.println(cnt);
				stmt.close();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt);
		}
	}

	public void Confirm(String homeworkId, String studentId) {
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = JDBCConnection.getConnection();
			String sql = "update hw_submit set confirm = 'O' where homeworkId = ? and id = ?"; 
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, homeworkId);
			stmt.setString(2, studentId);
			int cnt = stmt.executeUpdate();
			System.out.println(cnt);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt);
		}
	}

	public ArrayList<UserInfo> StudentList(UserInfo user) {
		ArrayList<UserInfo> studentList = new ArrayList<UserInfo>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			System.out.println(user.getClas()+","+ user.getGrade());
			conn = JDBCConnection.getConnection();
			String sql = "select * from hw_user where grade = ? and class = ? and position = '학생'";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, user.getGrade());
			stmt.setString(2, user.getClas());
			rs = stmt.executeQuery();
			while(rs.next()) {
				UserInfo student = new UserInfo();
				student.setId(rs.getString(1));
				student.setPw(rs.getString(2));
				student.setName(rs.getString(3));
				student.setTel(rs.getString(4));
				student.setParent(rs.getString(5));
				student.setGrade(rs.getString(6));
				student.setClas(rs.getString(7));
				student.setNum(rs.getString(8));
				student.setPosition(rs.getString(9));
				student.setConfirm(rs.getString(10));
				studentList.add(student);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return studentList;
	}

	public void MakeQuest(ArrayList<QuestInfo> questList, HomeworkInfo homework) {
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = null;
		try {
			conn = JDBCConnection.getConnection();
			sql = "insert into hw_homework values((select nvl(max(homeworkId)+1,0) from hw_homework),?,?,?,?,sysdate,?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, homework.getGrade());
			stmt.setString(2, homework.getClas());
			stmt.setString(3, homework.getTitle());
			stmt.setString(4, homework.getSubject());
			stmt.setString(5, homework.getEnDate());
			int cnt = stmt.executeUpdate();
			System.out.println(cnt);
			 for(int i = 0 ; i < questList.size() ; i++) {
				stmt.close();
				QuestInfo quest = questList.get(i);
				sql = "insert into hw_quest values((select max(homeworkId) from hw_homework), ?,?,?,?,?,?,?,?,?)";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, quest.getQuestNum());
				stmt.setString(2, quest.getKind());
				stmt.setString(3, quest.getQuest());
				stmt.setString(4, quest.getAnswer());
				stmt.setString(5, quest.getFirst());
				stmt.setString(6, quest.getSecond());
				stmt.setString(7, quest.getThird());
				stmt.setString(8, quest.getFourth());
				stmt.setString(9, quest.getFifth());
				cnt = stmt.executeUpdate();
				System.out.println(cnt);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt);
		}
		
	}

	public String OverlapId(String id) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String overlap = null;
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select * from hw_user where id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			if(rs.next()) overlap = "1";
			else overlap = "0";
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		return overlap;
	}
}
