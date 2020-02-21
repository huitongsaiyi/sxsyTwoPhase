<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>调查取证管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/bootstrap/colResizable-1.6.min.js"></script>
	<script src="${ctxStatic}/bootstrap/bootstrap-table-resizable.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#contentTable").colResizable({
				liveDrag:true,//拖动列时更新表布局
				gripInnerHtml:"<div class='grip'></div>",
				draggingClass:"dragging",
				resizeMode:'overflow',//允许溢出父容器
				defaults : true,
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
	<style type="text/css">
		#contentTable {
			table-layout: fixed;
		}

		#contentTable th {
			text-align: center; /** 设置水平方向居中 */
			vertical-align: middle; /** 设置垂直方向居中 */
		}

		#contentTable td {
			word-break: keep-all; /* 不换行 */
			white-space: nowrap; /* 不换行 */
			overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */
			text-overflow: ellipsis; /* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用。*/
		}

		#contentTable th:nth-of-type(23) {
			width: 10em;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/nestigateeividence/investigateEvidence/">调查取证列表</a></li>
<%--
		<shiro:hasPermission name="nestigateeividence:investigateEvidence:edit"><li><a href="${ctx}/nestigateeividence/investigateEvidence/form">添加</a></li></shiro:hasPermission>
--%>
	</ul>
	<form:form id="searchForm" modelAttribute="investigateEvidence" action="${ctx}/nestigateeividence/investigateEvidence/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<%--<li><label>报案人姓名：</label>
				<form:input path="reportRegistration.reportEmp" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>患者姓名：</label>
				<form:input path="complaintMain.patientName" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label style="width: 100px;">患方联系方式：</label>
				<form:input path="reportRegistration.patientMobile" htmlEscape="false" maxlength="15" class="input-medium"/>
			</li>
			<li><label>处理日期：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="${investigateEvidence.startTime}"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/> -
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="${investigateEvidence.endTime}"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</li>--%>
				<li><label>案件编号：</label>
					<form:input path="complaintMain.caseNumber" htmlEscape="false" maxlength="32" class="input-medium"/>
				</li>
				<li><label>报案时间：</label>
					<input name="reportTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
						   value="${investigateEvidence.reportRegistration.reportTime}"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				</li>
				<li><label>患者姓名：</label>
					<form:input path="complaintMain.patientName" htmlEscape="false" maxlength="32" class="input-medium"/>
				</li>
				<li><label style="width: 100px;">涉及医院：</label>
					<sys:treeselect id="involveHospital" name="complaintMain.involveHospital" value="${investigateEvidence.complaintMain.involveHospital}" labelName="hospitalName" labelValue="${investigateEvidence.complaintMain.hospital.name}"
									title="部门" url="/sys/office/treeData?type=1&officeType=2" isAll="true" cssClass="input-small" allowClear="true" notAllowSelectParent="false"/>
				</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><input id="btnReset" class="btn btn-primary" type="reset" value="重置"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-bordered table-condensed">
		<thead>
			<tr>
				<th class="sort-column case_number" style="text-align: center;">案件编号</th>
				<th class="sort-column r.dispute_time" style="text-align: center;">受理时间</th>
				<th class="sort-column patient_name" style="text-align: center;">患者姓名</th>
				<th class="sort-column involve_hospital" style="text-align: center;">涉及医院</th>
				<th class="sort-column au.insurance_company" style="text-align: center;">保险公司</th>
				<th class="sort-column au.treatment_outcome" style="text-align:center;">诊疗结果</th>
				<th class="sort-column report_emp" style="text-align: center;">涉及核心制度</th>
				<th class="sort-column b.is_major" style="text-align: center;">是否重大</th>
				<th  style="text-align: center;">是否媒体介入</th>
				<th  style="text-align:center;">部门名称</th>
				<th  style="text-align:center;">调解员</th>
				<%--<td>医方联系电话</td>--%>
				<shiro:hasPermission name="nestigateeividence:investigateEvidence:edit"><th style="text-align: center;">操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="investigateEvidence" varStatus="num">
			<tr ${not empty investigateEvidence.complaintMain.isMajor ? "style='background-color: red;'" : ""}>
				<td style="text-align: center;"><a href="${ctx}/nestigateeividence/investigateEvidence/form?id=${investigateEvidence.investigateEvidenceId}&type=view">
						${investigateEvidence.complaintMain.caseNumber}
				</a>
				</td>
				<td style="text-align:center;">
					<fmt:formatDate value="${investigateEvidence.auditAcceptance.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td style="text-align:center;">
						${investigateEvidence.complaintMain.patientName}
				</td>
				<td style="text-align: center;">
					${investigateEvidence.complaintMain.hospital.name}
				</td>
				<td style="text-align: center;">
                        ${investigateEvidence.auditAcceptance.insuranceCompany}
				</td>
				<td style="text-align:center;">
						${investigateEvidence.auditAcceptance.treatmentOutcome}
				</td>
				<td style="text-align:center;">

				</td>
				<td style="text-align:center;">
					<c:choose>
						<c:when test="${not empty investigateEvidence.complaintMain.isMajor}">
							<a href="${ctx}/major/majorInfo/form?id=${investigateEvidence.complaintMain.isMajor}&complaintMainId=${investigateEvidence.complaintMainId}">是</a>
						</c:when>
						<c:otherwise>
							<a href="${ctx}/major/majorInfo/form?id=${investigateEvidence.complaintMain.isMajor}&complaintMainId=${investigateEvidence.complaintMainId}">否</a>
						</c:otherwise>
					</c:choose>
				</td>
				<td style="text-align:center;">
				</td>

				<td style="text-align:center;">
						${fns:getUserById(investigateEvidence.createUser).office.name}
				</td>
				<td style="text-align:center;">
						${fns:getUserById(investigateEvidence.createUser).name}
				</td>
				<shiro:hasPermission name="nestigateeividence:investigateEvidence:edit"><td style="text-align: center;">
					<c:if test="${fns:getUser().loginName eq investigateEvidence.complaintMain.act.assigneeName}">
						<a href="${ctx}/nestigateeividence/investigateEvidence/form?id=${investigateEvidence.investigateEvidenceId}">处理</a>
						<a href="${ctx}/stopmediate/stopMediate/form?complaintMainId=${investigateEvidence.complaintMainId}&taskId=${investigateEvidence.complaintMain.act.taskId}&module=badj&url3=/nestigateeividence/investigateEvidence/?repage">终止调解</a>
					</c:if>
					<a href="${ctx}/nestigateeividence/investigateEvidence/form?id=${investigateEvidence.investigateEvidenceId}&type=view">详情</a>
<%--
					<a href="${ctx}/nestigateeividence/investigateEvidence/delete?id=${investigateEvidence.id}" onclick="return confirmx('确认要删除该成功吗？', this.href)">删除</a>
--%>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
</html>