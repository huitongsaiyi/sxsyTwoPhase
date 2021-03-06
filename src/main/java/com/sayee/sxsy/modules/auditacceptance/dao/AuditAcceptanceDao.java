/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.sayee.sxsy.modules.auditacceptance.dao;

import com.sayee.sxsy.common.persistence.CrudDao;
import com.sayee.sxsy.common.persistence.annotation.MyBatisDao;
import com.sayee.sxsy.modules.auditacceptance.entity.AuditAcceptance;

/**
 * 审核受理DAO接口
 * @author zhangfan
 * @version 2019-06-10
 */
@MyBatisDao
public interface AuditAcceptanceDao extends CrudDao<AuditAcceptance> {
	
}