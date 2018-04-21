<!-- DB에서 학생정보를 받아와 페이지단위만큼 출력하는 JSP -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Study.jdbc2.*" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>
<%
int currentPage = 1;
int pageSize = 10;
String pg = request.getParameter("pg");
if (pg != null) currentPage = Integer.parseInt(pg);
String name = request.getParameter("name")==null?"":request.getParameter("name");
List<Student> list = StudentDAO2.findName(currentPage, pageSize,name);
//전체 학생수를 받아옴
int recordCount = StudentDAO2.count(name);
//페이지의 개수= 전체 학생수/페이지사이즈의  올림
%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
      body { font-family: 굴림체; }
      thead th { background-color: #eee; }
      table.table { width: 700px; }
  </style>
</head>
<body>

<div class="container">
<h1>학생목록</h1>
<form class="form-inline">
	<div class="form-group">
		<label>이름</label>
		<input class="form-control" type="text" name="name" style="width:200px" value="<%=name%>" placeholder="검색조건"/>	
	</div>
	<button class="btn btn-primary">조회</button>
</form>
<table class="table table-bordered table-condensed">
    <thead>
        <tr>
            <th>id</th>
            <th>학번</th>
            <th>이름</th>
            <th>학과</th>
            <th>학년</th>
        </tr>
    </thead>
    <tbody>
        <% for (Student student : list) { %>
            <tr>
                <td><%= student.getId() %></td>
                <td><%= student.getStudentNumber() %></td>
                <td><%= student.getName() %></td>
                <td><%= student.getDepartmentName() %></td>
                <td><%= student.getYear() %></td>
            </tr>
        <% } %>
    </tbody>
</table>
<!-- 페이지사이즈를 받아가서 그만큼 레코드수를 출력하고 전체레코드수는 recordCount 변수로 초기화해서 페이지를 그만큼 만듬 -->
<my:pagination pageSize="<%= pageSize %>" recordCount="<%= recordCount %>" queryStringName="pg" />

</div>
</body>
</html>