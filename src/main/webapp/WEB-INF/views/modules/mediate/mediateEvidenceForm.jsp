<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>质证调解管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });

        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/mediate/mediateEvidence/">质证调解列表</a></li>
    <li class="active"><a href="${ctx}/mediate/mediateEvidence/form?id=${mediateEvidence.id}">质证调解<shiro:hasPermission
            name="mediate:mediateEvidence:edit">${not empty mediateEvidence.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="mediate:mediateEvidence:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="mediateEvidence" action="${ctx}/mediate/mediateEvidence/save" method="post"
           class="form-horizontal">
    <form:hidden path="mediateEvidenceId"/>
    <sys:message content="${message}"/>
    <ul id="myTab" class="nav nav-tabs">
        <li class="active">
            <a href="#mediation" data-toggle="tab">调解志</a>
        </li>
        <li>
            <a href="#meeting" data-toggle="tab">调解会议表</a>
        </li>
        <li>
            <a href="#recorded_patient" data-toggle="tab">调解会笔录（患方）</a>
        </li>
        <li>
            <a href="#recorded_doctor" data-toggle="tab">调解会笔录（医方）</a>
        </li>
        <li>
            <a href="#annex" data-toggle="tab">附件</a>
        </li>
    </ul>
    <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade in active" id="mediation">

        </div>
        <div class="tab-pane fade in active" id="meeting">
            <table class="table-form">
                <tr>
                    <td class="tit">时间:</td>
                    <td>
                        <input name="meetingTime" type="text" readonly="readonly" maxlength="20"
                               class="input-medium Wdate "
                               value="${mediateEvidence.meetingTime}"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
                    </td>
                    <td class="tit">地点:</td>
                    <td>
                        <form:input path="meetingAddress" htmlEscape="false" maxlength="20" class="input-xlarge "/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">案件:</td>
                    <td>
                        <form:input path="caseInfoName" htmlEscape="false" maxlength="20" class="input-xlarge "/>
                    </td>
                    <td class="tit">医方:</td>
                    <td class="controls">
                        <sys:treeselect id="doctor" name="complaintMain.involveEmployee"
                                        value="${mediateEvidence.doctor}" labelName=""
                                        labelValue="${mediateEvidence.complaintMain.employee.name}"
                                        title="用户" url="/sys/office/treeData?type=3&officeType=2" cssClass=""
                                        allowClear="true" notAllowSelectParent="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">医调委人员:</td>
                    <td>
                        <sys:treeselect id="user.name" name="user.name"
                                        value="${mediateEvidence.user.name}" labelName=""
                                        labelValue="${mediateEvidence.user.name}"
                                        title="用户" url="/sys/office/treeData?type=3&officeType=1" cssClass=""
                                        allowClear="true" notAllowSelectParent="true" checked="true"/>
                    </td>
                    <td class="tit">患方</td>
                    <td>
                        <form:input path="patient" htmlEscape="false" maxlength="20" class="input-xlarge "
                                    value="${mediateEvidence.patient}"/>
                    </td>
                </tr>
                <td style="text-align: center;"><input id="btnGenerate" class="btn" type="button" value="生成会议表"></td>
            </table>
        </div>
        <div class="tab-pane fade in active" id="recorded_patient">
            <table class="table-form">
                <tr>
                    <td class="tit">开始时间</td>
                    <td>
                        <input name="recordInfo.startTime" type="text" readonly="readonly" maxlength="20"
                               class="input-medium Wdate "
                               value="${mediateEvidence.recordInfo.startTime}"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
                    </td>
                    <td class="tit">结束时间</td>
                    <td>
                        <input name="recordInfo.endTime" type="text" readonly="readonly" maxlength="20"
                               class="input-medium Wdate "
                               value="${mediateEvidence.recordInfo.endTime}"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">地点</td>
                    <td>
                        <form:input path="recordInfo.recordAddress" htmlEscape="false" maxlength="20"
                                    class="input-xlarge "/>
                    </td>
                    <td class="tit">事由</td>
                    <td>
                        <form:input path="recordInfo.cause" htmlEscape="false" maxlength="20" class="input-xlarge "/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">主持人</td>
                    <td>
                        <sys:treeselect id="recordInfo.host" name="recordInfo.host"
                                        value="${mediateEvidence.recordInfo.host}" labelName=""
                                        labelValue="${mediateEvidence.recordInfo.host}"
                                        title="用户" url="/sys/office/treeData?type=2&officeType=1" cssClass=""
                                        allowClear="true" notAllowSelectParent="true"/>
                    </td>
                    <td class="tit">记录人</td>
                    <td>
                        <sys:treeselect id="recordInfo.noteTaker" name="recordInfo.noteTaker"
                                        value="${mediateEvidence.recordInfo.noteTaker}" labelName=""
                                        labelValue="${mediateEvidence.recordInfo.noteTaker}"
                                        title="用户" url="/sys/office/treeData?type=2&officeType=1" cssClass=""
                                        allowClear="true" notAllowSelectParent="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">患方</td>
                    <td>
                        <form:input path="recordInfo.patient" htmlEscape="false" maxlength="20" class="input-xlarge "/>
                    </td>
                    <td class="tit">医方</td>
                    <td>
                        <sys:treeselect id="recordInfo.doctor" name="recordInfo.doctor"
                                        value="${mediateEvidence.recordInfo.doctor}" labelName=""
                                        labelValue="${mediateEvidence.recordInfo.doctor}"
                                        title="用户" url="/sys/office/treeData?type=3&officeType=2" cssClass=""
                                        allowClear="true" notAllowSelectParent="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">其他参加人员</td>
                    <td>
                        <form:input path="recordInfo.otherParticipants" htmlEscape="false" maxlength="20"
                                    class="input-xlarge "/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">笔录内容</td>
                    <td colspan="3">
                        <form:textarea path="recordInfo.recordContent" htmlEscape="false" class="input-xlarge "
                                       style="margin: 0px; width: 938px; height: 125px;"/>
                    </td>
                </tr>
            </table>
        </div>
        <div class="tab-pane fade in active" id="recorded_doctor">
            <table class="table-form">
                <tr>
                    <td class="tit">开始时间</td>
                    <td>
                        <input name="recordInfo.yrecordInfo.startTime" type="text" readonly="readonly" maxlength="20"
                               class="input-medium Wdate "
                               value="${mediateEvidence.recordInfo.yrecordInfo.startTime}"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
                    </td>
                    <td class="tit">结束时间</td>
                    <td>
                        <input name="recordInfo.yrecordInfo.endTime" type="text" readonly="readonly" maxlength="20"
                               class="input-medium Wdate "
                               value="${mediateEvidence.recordInfo.yrecordInfo.endTime}"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">地点</td>
                    <td>
                        <form:input path="recordInfo.yrecordInfo.recordAddress" htmlEscape="false" maxlength="20"
                                    class="input-xlarge "/>
                    </td>
                    <td class="tit">事由</td>
                    <td>
                        <form:input path="recordInfo.yrecordInfo.cause" htmlEscape="false" maxlength="20"
                                    class="input-xlarge "/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">主持人</td>
                    <td>
                        <sys:treeselect id="recordInfo.yrecordInfo.host" name="recordInfo.yrecordInfo.host"
                                        value="${mediateEvidence.recordInfo.yrecordInfo.host}" labelName=""
                                        labelValue="${mediateEvidence.recordInfo.yrecordInfo.noteTaker}"
                                        title="用户" url="/sys/office/treeData?type=2&officeType=1" cssClass=""
                                        allowClear="true" notAllowSelectParent="true"/>
                    </td>
                    <td class="tit">记录人</td>
                    <td>
                        <sys:treeselect id="recordInfo.yrecordInfo.noteTaker" name="recordInfo.yrecordInfo.noteTaker"
                                        value="${mediateEvidence.recordInfo.yrecordInfo.noteTaker}" labelName=""
                                        labelValue="${mediateEvidence.complaintMain.employee.name}"
                                        title="用户" url="/sys/office/treeData?type=2&officeType=1" cssClass=""
                                        allowClear="true" notAllowSelectParent="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">患方</td>
                    <td>
                        <form:input path="recordInfo.yrecordInfo.patient" htmlEscape="false" maxlength="20"
                                    class="input-xlarge "/>
                    </td>
                    <td class="tit">医方</td>
                    <td>
                        <sys:treeselect id="recordInfo.yrecordInfo.doctor" name="recordInfo.yrecordInfo.doctor"
                                        value="${mediateEvidence.recordInfo.yrecordInfo.doctor}" labelName=""
                                        labelValue="${mediateEvidence.recordInfo.yrecordInfo.doctor}"
                                        title="用户" url="/sys/office/treeData?type=3&officeType=2" cssClass=""
                                        allowClear="true" notAllowSelectParent="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">其他参加人员</td>
                    <td>
                        <form:input path="recordInfo.yrecordInfo.otherParticipants" htmlEscape="false" maxlength="20"
                                    class="input-xlarge "/>
                    </td>
                </tr>
                <tr>
                    <td class="tit">笔录内容</td>
                    <td colspan="3">
                        <form:textarea path="recordInfo.yrecordInfo.recordContent" htmlEscape="false" class="input-xlarge "
                                       style="margin: 0px; width: 938px; height: 125px;"/>
                    </td>
                </tr>
            </table>
        </div>
        <div class="tab-pane fade in active" id="annex">
            <tr>
                <input type="hidden" name="fjtype" value="0">
                <td style="width: 450px; margin-left:20px;  display:inline-block; height: 50px; margin-top: -40px;">
                    签到表：
                    <input type="hidden" id="files" name="files" htmlEscape="false" class="input-xlarge"
                           value="${files}"/>
                        <%--<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="input-xlarge"/>--%>
                        <%--<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="input-xlarge" name="filess" />--%>
                    <sys:ckfinder input="files" type="files" uploadPath="/mediateEvidence/annex" selectMultiple="false"
                                  maxWidth="100" maxHeight="100"/>
                </td>
            </tr>
            <tr>
                <input type="hidden" name="fjtype1" value="1">
                <td style="width: 450px; margin-left:20px;  display:inline-block; height: 50px; margin-top: -40px;">
                    患方笔录：
                    <input type="hidden" id="files1" name="files1" htmlEscape="false" class="input-xlarge"
                           value="${files1}"/>
                        <%--<form:hidden id="files1" path="files1" htmlEscape="false" maxlength="255" class="input-xlarge"/>--%>
                        <%--<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="input-xlarge" name="filess" />--%>
                    <sys:ckfinder input="files1" type="files" uploadPath="/mediateEvidence/annex"
                                  selectMultiple="false"
                                  maxWidth="100" maxHeight="100"/>
                </td>
            </tr>
            <tr>
                <input type="hidden" name="fjtype2" value="2">
                <td style="width: 450px; margin-left:20px;  display:inline-block; height: 50px; margin-top: -40px;">
                    患方补充材料：
                    <input type="hidden" id="files2" name="files2" htmlEscape="false" class="input-xlarge"
                           value="${files2}"/>
                        <%--<form:hidden id="files2" path="files2" htmlEscape="false" maxlength="255" class="input-xlarge"/>--%>
                        <%--<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="input-xlarge" name="filess" />--%>
                    <sys:ckfinder input="files2" type="files" uploadPath="/mediateEvidence/annex"
                                  selectMultiple="false"
                                  maxWidth="100" maxHeight="100"/>
                </td>
            </tr>
            <tr>
                <input type="hidden" name="fjtype3" value="3">
                <td style="width: 450px; margin-left:20px;  display:inline-block; height: 50px; margin-top: -40px;">
                    医方笔录：
                    <input type="hidden" id="files3" name="files3" htmlEscape="false" class="input-xlarge"
                           value="${files3}"/>
                        <%--<form:hidden id="nameImage" path="files" htmlEscape="false" maxlength="255" class="input-xlarge"/>--%>
                        <%--<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="input-xlarge" name="filess" />--%>
                    <sys:ckfinder input="files3" type="files" uploadPath="/mediateEvidence/annex"
                                  selectMultiple="false"
                                  maxWidth="100" maxHeight="100"/>
                </td>
            </tr>
            <tr>
                <input type="hidden" name="fjtype4" value="4">
                <td style="width: 450px; margin-left:20px;  display:inline-block; height: 50px; margin-top: -40px;">
                    医方补充材料：
                    <input type="hidden" id="files4" name="files4" htmlEscape="false" class="input-xlarge"
                           value="${files4}"/>
                        <%--<form:hidden id="nameImage" path="files" htmlEscape="false" maxlength="255" class="input-xlarge"/>--%>
                        <%--<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="input-xlarge" name="filess" />--%>
                    <sys:ckfinder input="files4" type="files" uploadPath="/mediateEvidence/annex"
                                  selectMultiple="false"
                                  maxWidth="100" maxHeight="100"/>
                </td>
            </tr>
        </div>
    </div>
    <table class="table-form">
        <tr>
            <td class="tit">调解结果</td>
            <td>
                <form:select path="mediateResult" cssStyle="width: 180px">
                    <form:option value="1">成功</form:option>
                    <form:option value="2">失败</form:option>
                </form:select>
            </td>
        </tr>
        <tr>
            <td class="tit">会议总结</td>
            <td colspan="3">
                <form:textarea path="summary" htmlEscape="false" class="input-xlarge "
                               style="margin: 0px; width: 938px; height: 125px;"/>
            </td>
        </tr>
        <tr>
            <td class="tit">处理人</td>
            <td>
                <form:input path="handlePeople" htmlEscape="false" maxlength="20" class="input-xlarge "/>
            </td>
            <td class="tit">处理日期</td>
            <td>
                <input name="handleTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                       value="${mediateEvidence.handleTime}"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
            </td>
        </tr>
        <tr>
            <td class="tit"><font color="red">*</font>下一处理环节：</td>
            <td>
                <form:input path="nextLink" htmlEscape="false" maxlength="32" class="input-xlarge "/>
            </td>
            <td class="tit"><font color="red">*</font>下一环节处理人：</td>
            <td>
                    <%--<form:input path="nextLinkMan" htmlEscape="false" maxlength="32" class="input-xlarge "/>--%>
                <sys:treeselect id="nextLinkMan" name="nextLinkMan" value="${mediateEvidence.nextLinkMan}" labelName=""
                                labelValue="${mediateEvidence.nextLinkMan}"
                                title="用户" url="/sys/office/treeData?type=3&officeType=1" cssClass="" allowClear="true"
                                notAllowSelectParent="true" checked="true"/>
            </td>
        </tr>
    </table>
    <%--<div class="control-group">--%>
    <%--<label class="control-label"><font color="red">*</font>调解结果：</label>--%>
    <%--<div class="controls">--%>
    <%--<form:select path="mediateResult" cssStyle="width: 180px">--%>
    <%--<form:option value="1">成功</form:option>--%>
    <%--<form:option value="2">失败</form:option>--%>
    <%--</form:select>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="control-group">--%>
    <%--<label class="control-label">会议总结：</label>--%>
    <%--<div class="controls">--%>
    <%--<form:textarea path="summary" htmlEscape="false" rows="4" class="input-xxlarge "/>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="control-group">--%>
    <%--<label class="control-label">处理人：</label>--%>
    <%--<div class="controls">--%>
    <%--<form:input path="handlePeople" htmlEscape="false" maxlength="10" class="input-xlarge "/>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="control-group">--%>
    <%--<label class="control-label">处理日期：</label>--%>
    <%--<div class="controls">--%>
    <%--<input name="handleTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "--%>
    <%--value="<fmt:formatDate value="${mediateEvidence.handleTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"--%>
    <%--onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="control-group">--%>
    <%--<label class="control-label">下一处理环节：</label>--%>
    <%--<div class="controls">--%>
    <%--<form:input path="nextLink" htmlEscape="false" maxlength="32" class="input-xlarge "/>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="control-group">--%>
    <%--<label class="control-label">下环节处理人：</label>--%>
    <%--<div class="controls">--%>
    <%--<form:input path="nextLinkMan" htmlEscape="false" maxlength="32" class="input-xlarge "/>--%>
    <%--</div>--%>
    <%--</div>--%>
    <div class="form-actions">
        <shiro:hasPermission name="registration:reportRegistration:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" onclick="$('#flag').val('no')"/>&nbsp;</shiro:hasPermission>
        <shiro:hasPermission name="registration:reportRegistration:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="下一步" onclick="$('#flag').val('yes')"/>&nbsp;</shiro:hasPermission>

        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>