<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>전체 대여 이력 관리 | 관리자</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
}

.container {
	margin-top: 40px;
	margin-bottom: 50px;
}

.table-card {
	background: white;
	border-radius: 15px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
	padding: 25px;
}

.overdue-row {
	background-color: #fff5f5 !important;
} /* 연체 항목 배경색 */
.status-badge {
	font-size: 0.85rem;
	width: 85px;
}
</style>
</head>
<body>

	<div class="container">
		<div class="d-flex justify-content-between align-items-center mb-4">
			<div>
				<h2 class="fw-bold text-dark m-0">📜 전체 대여 이력 관리</h2>
				<p class="text-muted small mb-0">사내 모든 비품의 대여 및 반납 현황을 모니터링합니다.</p>
			</div>
			<a href="${pageContext.request.contextPath}/admin/adminPage"
				class="btn btn-outline-secondary"> 관리자 홈으로 </a>
		</div>

		<div class="table-card">
			<div class="table-responsive">
				<table class="table table-hover align-middle">
					<thead class="table-light">
						<tr>
							<th class="text-center">번호</th>
							<th>대여자 정보</th>
							<th>품목명</th>
							<th class="text-center">대여일</th>
							<th class="text-center">반납예정일</th>
							<th class="text-center">반납상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="r" items="${allRentals}">
							<tr
								class="${empty r.ret_act_date && r.ret_exp_date < today ? 'overdue-row' : ''}">
								<td class="text-center text-muted small">${r.rental_id}</td>
								<td><span class="fw-bold">${r.emp_name}</span> <span
									class="text-muted small">(${r.emp_id})</span></td>
								<td>${r.item_name}</td>
								<td class="text-center"><fmt:formatDate
										value="${r.rent_date}" pattern="yyyy-MM-dd" /></td>
								<td class="text-center"><fmt:formatDate
										value="${r.ret_exp_date}" pattern="yyyy-MM-dd" /></td>
								<td class="text-center"><c:choose>
										<c:when test="${not empty r.ret_act_date}">
											<span class="badge bg-light text-dark border status-badge">
												반납완료 </span>
										</c:when>
										<c:when test="${r.ret_exp_date < today}">
											<span class="badge bg-danger status-badge shadow-sm">연체
												중</span>
										</c:when>
										<c:otherwise>
											<span class="badge bg-primary status-badge">대여 중</span>
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
						<c:if test="${empty allRentals}">
							<tr>
								<td colspan="6" class="text-center py-5 text-muted">대여 이력이
									존재하지 않습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>