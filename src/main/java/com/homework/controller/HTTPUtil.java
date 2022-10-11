package com.homework.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HTTPUtil {
	public static void forward(HttpServletRequest request, HttpServletResponse response, String path) {
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		try {
			dispatcher.forward(request, response);
		} catch (Exception e) {
			System.out.println("forward 오류 : " + e);
			e.printStackTrace();
		}
	}
	public static void redirect(HttpServletResponse response, String path) {
		try {
			response.sendRedirect(path);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static void printOut(HttpServletResponse response, String data) {
		try {
			PrintWriter out = response.getWriter();
			out.print(data);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
