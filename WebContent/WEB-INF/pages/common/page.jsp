 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul style="float:right;" uib-pagination direction-links="false" boundary-links="true" total-items="totalItems" ng-model="currentPage" first-text="第一页" last-text="最后一页" items-per-page="itemsPerPage" ng-change="pageChanged()"></ul>